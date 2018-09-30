Aplikácia si vypýta od užívateľa povolenie k jeho lokácii. Podľa nej nájde čerpaciu stanicu najbližšiu k nemu a ponúkne možnosť zaznamenania ceny nafty.

Zoznam čerpacích staníc je zozbieraný pomocou služby http://overpass-turbo.eu/ touto query:

    (
      area[name="Slovensko"];(node[amenity=fuel](area););
    );
    out;

Plány do budúcna
- poskytnúť možnosti vyhľadávania čerpacej stanice
- umožniť zaznamenanie ceny aj iných typov paliva
