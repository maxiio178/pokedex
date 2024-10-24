public with sharing class PokeController {
    // List Pokemons
    @AuraEnabled(cacheable=true)
    public static List<Pokemons> fetchPokemonList() {
        try {
            return PokeServCallout.PokeServ();
        } catch (Exception ex) {
            throw new AuraHandledException('Error fetching Pokémon: ' + ex.getMessage());
        }
    }
}