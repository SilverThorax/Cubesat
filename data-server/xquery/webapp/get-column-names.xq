(: Author: Marek Pomocka :)

declare option output:method "json";

element json {
  attribute objects { 'json' },
  attribute arrays { 'columnNames' },
  element columnNames {
    for $n in db:open('satdata')/csv/record[1]/*
    return
    element value { $n/data() }
  }
}