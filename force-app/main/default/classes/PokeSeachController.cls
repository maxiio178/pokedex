public with sharing class PokeSaechController {
    // Pokemon by Name
    @AuraEnabled(cacheable=true)
    public static Pokemons fetchPokemonByName(String name) {
        List<Pokemons> pokemons = PokeServCallOut.getPokemonList();
        for (Pokemons pokemos : pokemons) {
            if (pokemon.name.equalsIgnoreCase(name)) {
                return pokemon;
            }
        }
        return null;
    }
}