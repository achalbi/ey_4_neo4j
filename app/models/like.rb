class Like 
	include Neo4j::ActiveRel
	#property :provider, :type => String

  from_class User
  to_class   User
  type 'likes'

end
