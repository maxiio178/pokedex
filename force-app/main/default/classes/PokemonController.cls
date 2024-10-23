public with sharing class PokemonController {

    // Método para exponer la lista de Pokémon a los LWC
    @AuraEnabled(cacheable=true)
    public static List<PokemonDTO> fetchPokemonList() {
        try {
            // Llamar al método del servicio que obtiene los Pokémon
            return PokeAPIService.getPokemonList();
        } catch (Exception ex) {
            throw new AuraHandledException('Error fetching Pokémon: ' + ex.getMessage());
        }
    }

    // Método para obtener un Pokémon filtrado por nombre
    @AuraEnabled(cacheable=true)
    public static PokemonDTO fetchPokemonByName(String name) {
        List<PokemonDTO> pokemons = PokeAPIService.getPokemonList();
        for (PokemonDTO pokemon : pokemons) {
            if (pokemon.name.equalsIgnoreCase(name)) {
                return pokemon;
            }
        }
        return null;
    }

    // Método para filtrar los Pokémon por tipo
    @AuraEnabled(cacheable=true)
    public static List<PokemonDTO> filterPokemonsByType(String type) {
        List<PokemonDTO> allPokemons = PokeAPIService.getPokemonList();
        List<PokemonDTO> filteredPokemons = new List<PokemonDTO>();

        for (PokemonDTO pokemon : allPokemons) {
            if (pokemon.type == type) {
                filteredPokemons.add(pokemon);
            }
        }
        return filteredPokemons;
    }
}
