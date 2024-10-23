public with sharing class PokemonController {

    // List Pokemons
    @AuraEnabled(cacheable=true)
    public static List<PokemonDto> fetchPokemonList() {
        try {
            return PokemonCalloutsService.getPokemonList();
        } catch (Exception ex) {
            throw new AuraHandledException('Error fetching Pokémon: ' + ex.getMessage());
        }
    }

    // Pokemons by name
    @AuraEnabled(cacheable=true)
    public static PokemonDto fetchPokemonByName(String name) {
        List<PokemonDto> pokemons = PokemonCalloutsService.getPokemonList();
        for (PokemonDto pokemon : pokemons) {
            if (pokemon.name.equalsIgnoreCase(name)) {
                return pokemon;
            }
        }
        return null;
    }

    //  Filter by Type
    @AuraEnabled(cacheable=true)
    public static List<PokemonDto> filterPokemonsByType(String type) {
        List<PokemonDto> allPokemons = PokeAPIService.getPokemonList();
        List<PokemonDto> filteredPokemons = new List<PokemonDTO>();

        for (PokemonDto pokemon : allPokemons) {
            if (pokemon.type == type) {
                filteredPokemons.add(pokemon);
            }
        }
        return filteredPokemons;
    }
}
