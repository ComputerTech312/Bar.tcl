#################################################################################################################################################################
# Barman.tcl 1.0.1
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
   array set bills {}

   array set drinks {
      beer   5
      wine   25
      water   2
      coke   3
      orange   4
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
      if {[lsearch [array names ::beer::drinks] $key] == -1} {
         putserv "PRIVMSG $chan :Sorry $nick, I haven't $key in the fridge"
         return 0
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
        putserv "PRIVMSG $chan :\001ACTION Gives the $key to $nick\001"
        putserv "PRIVMSG $chan : Enjoy your $key $nick, Your Total Bill Amount Is \$$::beer::bills($nick)"
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
   
}	


putlog "Barman 1.0.1 Loaded"
#################################################################################################################################################################
