# Find open TCP port
function findopenport
#    { port=2500
#                          while true
#                          do
#                              portlist=$(netstat -an -p tcp | egrep '^tcp4' | awk '{print $4}' | awk -F. '{print $NF}')  ## Mac OS version
##                              portlist=$(netstat -an --tcp | egrep '^tcp' | egrep -v 'tcp6' | awk '{print $4}' | awk -F: '{print $NF}')  ## Red Hat version
#                              if [[ "$portlist" =~ (^|[[:space:]])"$port"($|[[:space:]]) ]]
#                              then
#                                  port=$((port+1))
#                              else
#                                  break
#                              fi
#                          done
#                          echo $port; }
    set low_port 2500
    while true;
        set portlist (netstat -an -p tcp | grep '^tcp4' | awk '{print $4}' | awk -F. '{print $NF}')  # Mac OS version
        if string match -q -r -- "(^|[[:space:]])$low_port(\$|[[:space:]])" $portlist
            set low_port (math $low_port + 1)
        else
            break
        end
    end
    echo $low_port
end
