public with sharing class PokemonCalloutsService {

    public static List<PokemonDTO> getPokemonList() {
        List<PokemonDTO> pokemonList = new List<PokemonDTO>();
            
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


                PokemonDto details = getPokemonDetails(url);
                if (details != null) {
                    pokemonList.add(details);
                }
            }
            
            return pokemonList; 
    }

    @Future(callout=true)
    public static PokemonDto getPokemonDetails(String url) {
        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(url);
        request.setMethod('GET');
    
        HttpResponse response = http.send(request);
            if (response.getStatusCode() == 200) {
            Map<String, Object> data = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            PokemonDto dto = new PokemonDto();
    
            dto.id = (Integer) data.get('id');
            dto.name = (String) data.get('name');
            dto.logo = (String) ((Map<String, Object>) data.get('sprites')).get('front_default');
            dto.imgCard = (String) ((Map<String, Object>) data.get('sprites').get('other').get('official-artwork')).get('front_default');
            dto.types = (List<Object>) data.get('types');
    
    
        List<String> typeList = new List<String>();
            for (Object typeObj : dto.types) {
                Map<String, Object> typeMap = (Map<String, Object>) typeObj;
                typeList.add((String) ((Map<String, Object>) typeMap.get('type')).get('name'));
            }
            dto.types = typeList;
    
            return dto;
        }
            return null;
        }
    }
}