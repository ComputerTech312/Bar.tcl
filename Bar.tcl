#################################################################################################################################################################
# Bar.tcl 1.0
################################################################################################################################################################
#ComputerTech
#IRC Irc.mindforge.org #ComputerTech123
#EMAIL COMPUTERTECH312@GMAIL.COM
#GitHub  https://github.com/computertech312
#Forum http://tcldrop.forumotion.com
#Website http://tcl3.webnode.co.uk
#################################################################################################################################################################
#COMMANDS#
# Beer wine water coke orange pay menu
#################################################################################################################################################################
#START OF SETTINGS#
#Set trigger
set barcmd "!"
#END OF SETTINGS#
#################################################################################################################################################################

    namespace eval ::beer {
     global barcmd
 
    variable beer
     set pt "0"

    bind pub - "${barcmd}beer" ::beer::do_the_beer
    bind pub - "${barcmd}pay" ::beer::do_the_pay
    bind pub - "${barcmd}menu" ::beer::do_the_menu
    bind pub - "${barcmd}wine" ::beer::do_the_wine
    bind pub - "${barcmd}water" ::beer::do_the_water
    bind pub - "${barcmd}coke" ::beer::do_the_coke
    bind pub - "${barcmd}orange" ::beer::do_the_orange

    proc do_the_beer {nick uhost handle chan text} {
       variable beer
        global pt
       set guy [lindex [split $text] 0]
       set loaded [array names beer -exact $nick]
        if {$pt == 50} {
        putserv "privmsg $chan : $nick Your Tab is full With the amount of $pt Please pay before ordering more drink"     
         return               
     }
          incr pt +5
        putserv "PRIVMSG $chan :\001ACTION Fills up the glass with Beer\001"
        putserv "PRIVMSG $chan :\001ACTION Gives the Beer to $nick\001"
        putserv "privmsg $chan : Enjoy your Beer $nick, Your Total Bill Amount Is $pt"
       array unset beer $nick
    }

     proc do_the_wine {nick uhost handle chan text} {
       variable beer
        global pt
       set guy [lindex [split $text] 0]
       set loaded [array names beer -exact $nick]
        if {$pt == 50} {
        putserv "privmsg $chan : $nick Your Tab is full With the amount of $pt Please pay before ordering more drink"     
         return               
     }
          incr pt +25
        putserv "PRIVMSG $chan :\001ACTION Fills up the glass with Wine\001"
        putserv "PRIVMSG $chan :\001ACTION Gives the Wine to $nick\001"
        putserv "privmsg $chan : Enjoy your Wine $nick, Your Total Bill Amount Is $pt"
       array unset beer $nick
    }

     proc do_the_water {nick uhost handle chan text} {
       variable beer
        global pt
       set guy [lindex [split $text] 0]
       set loaded [array names beer -exact $nick]
        if {$pt == 50} {
        putserv "privmsg $chan : $nick Your Tab is full With the amount of $pt Please pay before ordering more drink"     
         return               
     }
          incr pt +2
        putserv "PRIVMSG $chan :\001ACTION Fills up the glass with Water\001"
        putserv "PRIVMSG $chan :\001ACTION Gives the Water to $nick\001"
        putserv "privmsg $chan : Enjoy your Water $nick, Your Total Bill Amount Is $pt"
       array unset beer $nick
    }

     proc do_the_orange {nick uhost handle chan text} {
       variable beer
        global pt
       set guy [lindex [split $text] 0]
       set loaded [array names beer -exact $nick]
        if {$pt == 50} {
        putserv "privmsg $chan : $nick Your Tab is full With the amount of $pt Please pay before ordering more drink"     
         return               
     }
          incr pt +3
        putserv "PRIVMSG $chan :\001ACTION Fills up the glass with Orange juice\001"
        putserv "PRIVMSG $chan :\001ACTION Gives the Orange Juice to $nick\001"
        putserv "privmsg $chan : Enjoy your Orange Juice $nick, Your Total Bill Amount Is $pt"
       array unset beer $nick
    }



     proc do_the_coke {nick uhost handle chan text} {
       variable beer
        global pt
       set guy [lindex [split $text] 0]
       set loaded [array names beer -exact $nick]
        if {$pt == 50} {
        putserv "privmsg $chan : $nick Your Tab is full With the amount of $pt Please pay before ordering more drink"     
         return               
     }
          incr pt +4
        putserv "PRIVMSG $chan :\001ACTION Fills up the glass with Coke\001"
        putserv "PRIVMSG $chan :\001ACTION Gives the Coke to $nick\001"
        putserv "privmsg $chan : Enjoy your Coke $nick, Your Total Bill Amount Is $pt"
       array unset beer $nick
    }

    proc do_the_pay {nick uhost handle chan text} {
       variable beer
        global pt
       set loaded [array names beer -exact $nick]
       if {$loaded != ""} {
          putserv "privmsg $chan :$nick Your Already Payed Your Bill"
          return
       }
       array set beer "$nick 1"
        putserv "privmsg $chan :$nick Thank You For Paying Your Bill, Here's your receipt"
        putserv "notice $chan : -------------------  "
        putserv "notice $chan :|Bar receipt                    "   
        putserv "notice $chan :| $ $pt  "
        putserv "notice $chan :| $nick       "
        putserv "notice $chan :| $chan"
        putserv "notice $chan : ------------------- "
        set pt "0"
    }
     

 proc do_the_menu {nick uhost handle chan text} {
 global barcmd
putserv "notice $nick :Welcome $nick This is our Menu"
 putserv "notice $nick :${barcmd}beer $ 5 , ${barcmd}water  $ 2 , {barcmd}wine $ 25 , ${barcmd}coke $ 4 ${barcmd}orange $ 3"
     }
    } ;# end namespace

putlog "PubCMD.tcl Made By ComputerTech LOADED"
#################################################################################################################################################################
