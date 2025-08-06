enum StreamType {
  stream('stream'),
  streamProcessed('stream:processed');

  final String value;
  const StreamType(this.value);
}
