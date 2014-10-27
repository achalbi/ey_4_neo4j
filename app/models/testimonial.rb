class Testimonial 
	include Neo4j::ActiveRel
	property :say, :type => String

  from_class User
  to_class   User
  type 'testimonials'

end
