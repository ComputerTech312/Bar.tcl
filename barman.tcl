################################################################################################################################################################# 
 # Bar.tcl 1.0.5 
 ################################################################################################################################################################# 
 #ComputerTech 
 #Irc     irc.technet.xi.ht #ComputerTech123 
 #Email   ComputerTech312@Gmail.com 
 #GitHub  https://github.com/computertech312 
 #Website http://tcl3.webnode.co.uk 
 ################################################################################################################################################################# 
 #START OF SETTINGS# 
 #Set trigger 

 set barcmd ";" 

 #Set the maxium amount the tab can be 

 set max "100" 


 #END OF SETTINGS# 
 ################################################################################################################################################################# 
     
 namespace eval ::beer { 

    variable barcmd ";" 
     variable beer 
    array set bills {} 

    array set drinks { 
       heineken 6 
       wine   18 
       water   1 
       coke   4 
       orange   2 
       vodka    10 
       brandy   15 
       whiskey   8 
       budwiser 7 
       guinness 8 
       carlsberg 6 
       redbull   4
       fanta     2 
       tea       4 
       coffee    5 
    } 
     
    foreach dr [array names drinks] { 
       bind pubm - "*$::beer::barcmd$dr*" ::beer::do_drink 
    } 
     
    bind pub - "${barcmd}pay" ::beer::do_the_pay 
    bind pub - "${barcmd}menu" ::beer::do_the_menu 

     proc do_drink {nick uhost handle chan text} { 
       set args [split $text " "] 
       set key [stripcodes abcgru [lindex $args 0]] 
       set key [string range $key 1 end] 
       if { [llength $args]==2 } { 
          set vict [stripcodes abcgru [lindex $args 1]] 
          if {![onchan $vict $chan]} { 
             putserv "PRIVMSG $chan :$nick, you can't afford a $key to $vict, she/he is not here" 
             return 0 
          } 
       } else { 
          set vict $nick 
       } 
       set cost $::beer::drinks($key) 
       if {[array names ::beer::bills -exact $nick] ne ""} { 
          set bill $::beer::bills($nick) 
          if {$bill >= 50} { 
             putserv "PRIVMSG $chan : $nick Your Tab is full With the amount of \$$bill Please pay before ordering more drink"    
             return  0            
          } 
       } else { 
          set ::beer::bills($nick) 0 
       } 
       incr ::beer::bills($nick) $cost 
       putserv "PRIVMSG $chan :\001ACTION Fills up the glass with $key\001" 
       putserv "PRIVMSG $chan :\001ACTION Gives the $key to $vict\001" 
       if {$vict eq $nick} {
   putserv "PRIVMSG $chan :Enjoy your $key $nick, Your Total Bill Amount Is \$$::beer::bills($nick)"
} else {
   putserv "PRIVMSG $chan :Enjoy your $key $vict, the Total Bill Amount for $nick is \$$::beer::bills($nick)"
} 
    } 

     proc do_the_pay {nick uhost handle chan text} { 
       set loaded [array names ::beer::bills -exact $nick] 
       if {$loaded eq ""} { 
          putserv "PRIVMSG $chan :$nick Your Already Payed Your Bill" 
          return 
       } 
       putserv "PRIVMSG $chan :$nick Thank You For Paying Your Bill, Here's your receipt" 
       putserv "NOTICE $nick : -------------------  " 
       putserv "NOTICE $nick :|Bar receipt                    "    
       putserv "NOTICE $nick :| \$$::beer::bills($nick)  " 
       putserv "NOTICE $nick :| $nick       " 
       putserv "NOTICE $nick :| $chan" 
       putserv "NOTICE $nick : ------------------- " 
       unset ::beer::bills($nick) 
     } 
       

    proc do_the_menu {nick uhost handle chan text} { 
       putserv "NOTICE $nick :Welcome $nick This is our Menu" 
       foreach {drink cost} [array get ::beer::drinks] { 
          putserv "NOTICE $nick :$::beer::barcmd$drink : \$$cost" 
       } 
    } 
     
    putlog "Barman 1.0.6 loaded" 
 }
