#!/bin/bash
if [ "$1" = "--help" ] || [ "$1" = "-h" ]; then
   echo "Updates:"
   echo "   update (--gitlab, --github) Updates Floflis dna (centralized, yet)"
fi

if [ "$1" = "update" ] || [ "$1" = "updt" ] || [ "$1" = "next" ] || [ "$1" = "up" ]; then
   if [ "$2" = "" ]; then
      echo "Can't update yet on a decentralized manner. Please use 'update --gitlab' command."
      echo ""
      echo "When you can't update from git, I ask you to keep your clonned git folder of Floflis dna, update using 'git pull' inside it, optionally open init.sh and then manually re-install it using install.sh."
      echo ""
      echo "Not a company developing Floflis. I'm Daniell W. J. Mesquita, a brazillian individual (persecuted with lawfare due to eco/social activism) developing Floflis thinking on common good. I promise I're working hard to make Floflis DNA upgradeable, and to enable P2P updates on Floflis dna."
      echo ""
      echo "Type 'floflis update --gitlab' to update from GitLab, or 'floflis update --github' to update from GitHub."
fi
fi

if [ "$1" = "update" ]; then
   if [ "$2" = "gitlab" ] || [ "$2" = "--gitlab" ]; then
      echo "- Updating Floflis dna (from GitLab)..."
      echo "(i) Updating a Layer requires sudo mode;"
     #only dna is updateable for now
      cd /usr/lib/floflis/layers/dna && sudo git pull origin master
      echo "(✓) Successfully updated Floflis dna (from GitLab)."
fi
   if [ "$2" = "github" ] || [ "$2" = "--github" ]; then
      echo "(?) GitHub is owned by Microsoft. Are you sure Microsoft likes us?"
      echo "1. Yes, I'll receive Floflis updates from Microsoft"
      echo "2. No"
      echo "Please type 1 or 2 according to your choice, and press [ENTER]:"
      read microsoftyes
      if [ "$microsoftyes" = "" ]; then
         echo "What?"
         floflis
fi
      if [ "$microsoftyes" = "2" ]; then
         echo "If you don't trust MS, you're a true Floflis citizen."
         floflis update
fi
      if [ "$microsoftyes" = "1" ]; then
         echo "If you receive a blue screen, don't blame on us." && echo "- Updating Floflis DNA (from Microsoft GitHub)..."
         echo "(i) Updating a Layer requires sudo mode;"
        #only dna is updateable for now
         cd /usr/lib/floflis/layers/dna && sudo git pull github master
         echo "(✓) Successfully updated Floflis dna (from GitHub)."
fi
fi
fi
