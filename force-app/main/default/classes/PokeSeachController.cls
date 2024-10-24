public with sharing class PokeSaechController {
    // Pokemon by Name
    @AuraEnabled(cacheable=true)
    public static Pokemons fetchPokemonByName(String name) {
        List<Pokemons> pokemons = PokeServCallOut.PokeServ();
        for (Pokemons pokemos : pokemons) {
            if (pokemos.name.equalsIgnoreCase(name)) {
                return pokemos;
            }
        }
        return null;
    }
}