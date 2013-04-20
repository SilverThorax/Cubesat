(: Author: Marek Pomocka :)

declare variable $col-names := for $n in 2 to 46 return 'col' || $n;
declare variable $labels := /csv/record[1]/*/data();

(
delete node /sat,
insert node
element sat {
  attribute name { 'Sat1' },
  for $e in /csv/subsequence(record, 2)
  return
  (: the measurement :)
  element mes {
    (: Convert time from CSV to XML Schema date time :)
    attribute time { xs:dateTime(replace($e/col, '(\d{2})/(\d{2})/(\d{4}) (.*)', '$3-$2-$1T$4')) },
    for $n in 2 to 46
    let $col := 'col' || $n
    return
    element { $labels[$n - 1] } { xs:decimal($e/*[name() eq $col]/data()) }
  }
}
into /,
insert node
element sat {
  attribute name { 'Sat2' },
  for $e in /csv/subsequence(record, 2)
  return
  (: the measurement :)
  element mes {
    (: Convert time from CSV to XML Schema date time :)
    attribute time { xs:dateTime(replace($e/col, '(\d{2})/(\d{2})/(\d{4}) (.*)', '$3-$2-$1T$4')) },
    for $n in 2 to 46
    let $col := 'col' || $n
    return
    (: change values randomly by 10% :)
    element { $labels[$n - 1] } { xs:decimal(xs:decimal($e/*[name() eq $col]/data()) * (1.0 + 0.1 *(random:double() - 0.5))) }
  }
}
into /
)