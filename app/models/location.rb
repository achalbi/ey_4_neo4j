class Location 
  include Neo4j::ActiveNode
  property :address, :type => String, :index => :exact
  property :latitude, :type => Float, :index => :exact
  property :longitude, :type => Float, :index => :exact 
 

  has_one :out, :places,  model_class: User,  rel_class: Place

end
