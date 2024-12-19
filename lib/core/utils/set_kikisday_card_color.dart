class SetKikisdayCardColor {
  static String setCardColor(int cardNum) {
    if (cardNum == 2 || cardNum == 4) {
      return 'green';
    } else if (cardNum == 3 || cardNum == 5) {
      return 'blue';
    } else if (cardNum == 6 || cardNum == 11 || cardNum == 14) {
      return 'orange';
    } else if (cardNum == 7 || cardNum == 8 || cardNum == 10) {
      return 'skyblue';
    } else if (cardNum == 12 || cardNum == 13) {
      return 'yellow';
    } else if (cardNum == 9 || cardNum == 15 || cardNum == 19) {
      return 'red';
    } else if (cardNum == 16 || cardNum == 18) {
      return 'purple';
    } else {
      return 'pink';
    }
  }
}
