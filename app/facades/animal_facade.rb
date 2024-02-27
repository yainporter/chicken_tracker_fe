class AnimalFacade
  attr_reader :params, :animal_service 
  
  def initialize(params)
    @params = params
    @animal_service = AnimalService.new
  end

  def id
    @params[:id]
  end

  def shelter_id
    @params[:shelter_id]
  end

  def allowed_species
  # this heavyweight method allows for a collection dropdown in the view

      [
        { id: 1, name: "Chicken" },
        { id: 2, name: "Bee" },
      ].map { |species| OpenStruct.new(species) }
  end

  def animal
    Animal.new(@animal_service.get_animal(@params[:id], @params[:shelter_id])[:data])
  end

  def create_animal(animal_data)
    Animal.new(@animal_service.create_animal(animal_data)[:data])
  end

  def update_animal(data)
    animal = Animal.new(@animal_service.update_animal_service(data, id)[:data])
    # if animal.attributes_match?(data)
    #   true
    # else
    #   false
    # end
  end
end


