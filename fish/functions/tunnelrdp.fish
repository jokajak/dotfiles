# Tunnel RDP sessions within SSH session
function tunnelrdp --description "Tunnel RDP session over ssh" --argument-names ssh_user ssh_host rdp_user rdp_host
    function help_exit
        echo "Usage: ssh_user ssh_host rdp_user rdp_host"
        # exit terminates the shell
    end

    if test -z "$ssh_user"; or test -z "$ssh_host"; or test -z "$rdp_user"; or test -z "$rdp_host"
        echo $ssh_user
        echo $ssh_host
        echo $rdp_user
        echo $rdp_host
        help_exit
    else
        set port (findopenport)
        echo "Tunneling RDP to $rdp_host via local port $port through $ssh_host"
        ssh -fNL $port:$rdp_host:3389 $ssh_user@$ssh_host
        #xfreerdp -grab-keyboard /u:$rdp_user +clipboard /floatbar:sticky:on,default:visible,show:always /w:100% /h:100% +multitransport /workarea /v:localhost:$port
        open -n -F -a /Applications/Microsoft\ Remote\ Desktop.app "rdp://full%20address=s:127.0.0.1:$port&username=s:$rdp_user&screen%20model%20id=i:1"
        sleep 10
        while true;
            set PID (pgrep -f '/Applications/Microsoft Remote Desktop.app/Contents/MacOS/Microsoft Remote Desktop')
            if test -z "$PID"
            else
                break;
            end
        end
        echo "Closing tunnel..."
        pkill -f 'ssh -fNL $port'
    end
end
