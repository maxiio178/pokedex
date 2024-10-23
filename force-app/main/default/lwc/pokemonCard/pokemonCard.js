import { LightningElement, api } from 'lwc';

export default class PokemonCard extends LightningElement {
    // Recibe datos del componente padre a través de 'api' (decorador)
    @api pokemon;

    get pokemonImage() {
        // Retorna la URL de la imagen del Pokémon, si está disponible
        return this.pokemon?.image || '';
    }

    get pokemonName() {
        // Retorna el nombre del Pokémon
        return this.pokemon?.name || 'No name';
    }

    get pokemonId() {
        // Retorna el ID del Pokémon
        return this.pokemon?.id || 'N/A';
    }

    get pokemonTypes() {
        // Combina todos los tipos en una sola cadena
        return this.pokemon?.types?.join(', ') || 'Unknown types';
    }
}
