(: Author: Marek Pomocka :)

declare option output:method "json";

element json {
  attribute objects { 'json' },
  attribute arrays { 'sateliteNames' },
  element sateliteNames {
    for $n in /sat/@name
    return
    element value { $n/data() }
  }
}