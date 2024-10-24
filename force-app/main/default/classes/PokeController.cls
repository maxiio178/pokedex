public with sharing class PokeController {
    // List Pokemons
    @AuraEnabled(cacheable=true)
    public static List<PokemonDto> fetchPokemonList() {
        try {
            return PokemonCalloutsService.getPokemonList();
        } catch (Exception ex) {
            throw new AuraHandledException('Error fetching Pokémon: ' + ex.getMessage());
        }
    }
}