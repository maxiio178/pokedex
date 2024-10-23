public class PokemonDTO {

    @AuraEnabled
    public Integer id { get; set; }  // Identificador del Pokémon

    @AuraEnabled
    public String name { get; set; }  // Nombre del Pokémon

    @AuraEnabled
    public String image { get; set; } // URL de la imagen del Pokémon

    @AuraEnabled
    public String type { get; set; }  // Tipo de Pokémon (si lo deseas agregar)
    
    @AuraEnabled
    public String location { get; set; } // Información sobre la ubicación (si aplica)

}
