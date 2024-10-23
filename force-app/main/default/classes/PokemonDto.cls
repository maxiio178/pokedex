public with sharing class PokemonDto {

    @AuraEnabled
    public Integer id { get; set; }

    @AuraEnabled
    public String name { get; set; }

    @AuraEnabled
    public String logo { get; set; }

    @AuraEnabled
    public List<String> types { get; set; }

    @AuraEnabled
    public String imgCard { get; set; }

}
