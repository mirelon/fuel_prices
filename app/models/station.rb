class Station < ApplicationRecord
  acts_as_mappable :default_units => :kms,
                   :default_formula => :sphere,
                   :distance_field_name => :distance,
                   :lat_column_name => :lat,
                   :lng_column_name => :lng

  def posledna_aktualizacia
    updated_at.localtime.strftime('%-d.%-m.%Y %H:%M:%S')
  end

  def as_json(options)
    super.as_json(options).merge({
        posledna_aktualizacia: posledna_aktualizacia,
        display_name: display_name
                                 })
  end

  def display_name
    common_names = %w(Slovnaft OMV Shell Benzinol Jurki Gulf Lukoil Oliva Tesco Oktan Tanker Avanti GAS Metro Agip)
    names = [name, brand, operator].uniq.compact
    intersect_names = names & common_names
    if intersect_names.present?
      intersect_names.first
    elsif names.present?
      names.first
    else
      'Bez názvu'
    end
  end
end
