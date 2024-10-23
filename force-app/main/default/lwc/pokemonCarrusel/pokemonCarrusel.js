import { LightningElement, api } from 'lwc';

export default class PokemonCarousel extends LightningElement {
    @api pokemons; // Recibir la lista de Pokémon

    handlePokemonClick(pokemon) {
        const event = new CustomEvent('pokemonselect', {
            detail: pokemon // Pasar el Pokémon seleccionado
        });
        this.dispatchEvent(event);
    }
}
