public with sharing class PokeFiterControler {
    //  Filter by Type
    @AuraEnabled(cacheable=true)
    public static List<Pokemons> filterPokemonsByType(List<String> types) {
        List<Pokemons> allPokemons = PokeServCallOut.getPokemonList();
        List<Pokemons> filteredPokemons = new List<Pokemons>();
        for (Pokemons pokemon : allPokemons) {
            Boolean hasMatchingType = false;
            for (String pokemonType : pokemon.types) {
                if (types.contains(pokemonType)) {
                    hasMatchingType = true;
                }
            }
            if (hasMatchingType) {
                filteredPokemons.add(pokemon);
            }
        }
        return filteredPokemons;
    }
}