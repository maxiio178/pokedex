import { LightningElement } from 'lwc';

export default class PokeFilters extends LightningElement {
    handleTypeFilter(event) {
        const type = event.target.dataset.type; // Obtener el tipo del botón
        const filterEvent = new CustomEvent('filterchange', {
            detail: type // Pasar el tipo al padre
        });
        this.dispatchEvent(filterEvent);
    }
}
