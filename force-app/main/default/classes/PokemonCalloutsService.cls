public with sharing class PokemonCalloutsService {

        // Método para obtener la lista de Pokémon desde la PokeAPI
        @AuraEnabled(cacheable=true)
        public static List<PokemonDTO> getPokemonList() {
            String url = 'https://pokeapi.co/api/v2/pokemon?limit=100';
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(url);
            request.setMethod('GET');
    
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                List<Object> pokemonResults = (List<Object>) results.get('results');
    
                List<PokemonDTO> pokemons = new List<PokemonDTO>();
                Integer count = 1;
                for (Object obj : pokemonResults) {
                    Map<String, Object> pokemonData = (Map<String, Object>) obj;
                    String name = (String) pokemonData.get('name');
                    String detailsUrl = (String) pokemonData.get('url');
    
                    PokemonDTO pokemon = new PokemonDTO();
                    pokemon.id = count++;
                    pokemon.name = name;
                    pokemon.image = getPokemonImage(detailsUrl); // Obtener la imagen del Pokémon
                    pokemons.add(pokemon);
                }
                return pokemons;
            } else {
                throw new AuraHandledException('Error retrieving Pokémon list');
            }
        }
    
        // Método auxiliar para obtener la imagen del Pokémon
        @Future(callout=true)
        public static String getPokemonImage(String detailsUrl) {
            Http http = new Http();
            HttpRequest request = new HttpRequest();
            request.setEndpoint(detailsUrl);
            request.setMethod('GET');
    
            HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
                Map<String, Object> pokemonDetails = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
                Map<String, Object> sprites = (Map<String, Object>) pokemonDetails.get('sprites');
                return (String) sprites.get('front_default');
            }
            return null;
        }
    
    
    
}