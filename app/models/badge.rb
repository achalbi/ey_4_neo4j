class Badge 
	include Neo4j::ActiveRel
	property :badgeType, :type => String
	property :color, :type => String

  from_class User
  to_class   User
  type 'badges'

end
