public with sharing class PokeServCallout {
    public static List<Pokemons> PokeServ() {
        List<Pokemons> pokemons = new List<Pokemons>();

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon?limit=151');
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            List<Object> results = (List<Object>) data.get('results');

            for (Object obj : results) {
                Map<String, Object> pokemonData = (Map<String, Object>) obj;
                String url = (String) pokemonData.get('url');

                // Obtener detalles del Pokémon y mostrarlos en la consola
                Pokemons details = getPokemonDetails(url);
                if (details != null) {
                    pokemons.add(details);
                }
            }
            return pokemons; 
        } else {
            System.debug('Error en la llamada a la API de Pokémon: ' + response.getStatus());
            return null; // O manejar de otra forma
        }
    }

    public static Pokemons getPokemonDetails(String url) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');

        HttpResponse response = http.send(request);
        if (response.getStatusCode() == 200) {
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            Pokemons dto = new Pokemons();

            dto.id = (Integer) data.get('id');
            dto.name = (String) data.get('name');
            dto.logo = (String) ((Map<String, Object>) data.get('sprites')).get('front_default');
            dto.imgCard = (String) ((Map<String, Object>) ((Map<String, Object>) ((Map<String, Object>) data.get('sprites')).get('other')).get('official-artwork')).get('front_default');
            dto.types = (List<Object>) data.get('types');

            List<String> typeList = new List<String>();
            for (Object typeObj : dto.types) {
                Map<String, Object> typeMap = (Map<String, Object>) typeObj;
                typeList.add((String) ((Map<String, Object>) typeMap.get('type')).get('name'));
            }
            dto.types = typeList;

            return dto;
        } else {
            System.debug('Error al obtener detalles del Pokémon: ' + response.getStatus());
            return null;
        }
    }
}