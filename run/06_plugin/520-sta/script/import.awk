#!/usr/bin/awk -f
BEGIN {
}
{
  if (NF>2) {
     if ($3 == "-") {
        print "INFO: skip importing file '"$2"' ("$1")"
     } else {
        print "INFO: copy file '"$3"' to :version/"$2" ("$1")"
        system("cp "$3" :version/"$2)
     }
  }
}
END {
}
