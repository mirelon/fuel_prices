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
        posledna_aktualizacia: posledna_aktualizacia
                                 })
  end
end
