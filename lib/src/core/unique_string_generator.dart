int _counter = 0;

/// A unique id for each toast within this isolate's lifetime.
String getUniqueString() => (_counter++).toString();
