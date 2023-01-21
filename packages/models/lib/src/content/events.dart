abstract class ContentEvent {

  factory ContentEvent.generate({
    required int size
  }) {
    return GenerateContent(size);
  }

  factory ContentEvent.refresh() => RefreshContent();
}

class RefreshContent implements ContentEvent {

}

class GenerateContent implements ContentEvent {

  GenerateContent(this.size);

  final int size;
}