Aplikácia si vypýta od užívateľa povolenie k jeho lokácii. Podľa nej nájde čerpaciu stanicu najbližšiu k nemu a ponúkne možnosť zaznamenania ceny nafty. Ak je na výber viac čerpacích staníc, užívateľ si môže vybrať z mapy.

Zoznam čerpacích staníc je zozbieraný pomocou služby http://overpass-turbo.eu/ touto query:

    (
      area[name="Slovensko"];(node[amenity=fuel](area););
    );
    out;
    
Mapové údaje sa získavajú pomocou služby https://thunderforest.com/.

Plány do budúcna
- poskytnúť možnosti vyhľadávania čerpacej stanice
- umožniť zaznamenanie ceny aj iných typov paliva
