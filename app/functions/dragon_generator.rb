module DragonGenerator
	class DragonGenerator
		def one
		end

		def two
		end
		def DragonGenerator.method_missing(m, *args)
		    method = m.to_s
		    if method.start_with?("player_")             
		      attr = method[7..-1]                         
		      if DragonGenerator.public_method_defined?(attr)       
		        DragonGenerator.find_all do |person|                
		          person.send(attr).include?(args[0])      
		        end                                        
		      else
		        raise ArgumentError, "Can't find #{attr}"  
		      end
		    else
		      super                                        
		    end
		end
	end
end
