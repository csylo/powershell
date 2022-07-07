#restarts network adapter since steam downloads cuts my connection when hitting 60mb/s

"netadapter watchdog on"
$loopCount = 0
$netFailCount = 0
while($true){
	$pingVal = ping -n 1 192.168.X.X
	if(($pingVal -like "*failure*") -or ($pingVal -like "*unreachable*") -or ($pingVal -like "*Request timed out.*")){
		     $netFailCount++
		     "Gateway ping failed on loop " + $loopCount + ". Resetting netadapter."
		     disable-netadapter -name "ethernet" -confirm:$false
		     start-sleep -seconds 5
		     enable-netadapter -name "ethernet" -confirm:$false
		     start-sleep -seconds 11
		     $recPingVal = ping -n 1 192.168.X.X
		     if(-not (($recPingVal -like "*failure*") -or ($recPingVal -like "*unreachable*") -or ($recPingVal -like "*Request timed out.*"))){
		     	     "Gateway ping OK."
		     }
	} else{
		start-sleep -seconds 5
	}
	$loopCount++
}
