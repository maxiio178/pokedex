import { LightningElement, track } from 'lwc';
import fetchPokemonList from '@salesforce/apex/PokemonController.fetchPokemonList';

export default class PokeApp extends LightningElement {
    @track pokemons = []; // Lista de Pokémon
    @track filteredPokemons = []; // Pokémon filtrados
    selectedPokemon;

    connectedCallback() {
        this.loadPokemonList();
    }

    async loadPokemonList() {
        this.pokemons = await fetchPokemonList();
        this.filteredPokemons = this.pokemons;
    }

    handleFilterChange(event) {
        const type = event.detail;
        this.filteredPokemons = this.pokemons.filter(pokemon => pokemon.type === type);
    }

    handlePokemonSelect(event) {
        this.selectedPokemon = event.detail;
    }
}
