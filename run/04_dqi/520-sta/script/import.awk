#!/usr/bin/awk -f
BEGIN {
}
{
  if (NF>2) {
     print "copy file '"$3"' to .data/"$2
     system("cp "$3" .data/"$2)
  }
}
END {
}
