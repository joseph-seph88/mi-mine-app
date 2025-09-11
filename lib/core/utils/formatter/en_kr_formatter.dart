class EnKrFormatter {
  static String formatEnKrOnPlaceType(String enText) {
    switch (enText) {
      case 'restaurant':
        return '식당';
      case 'dessert':
        return '디저트';
      case 'cafe':
        return '카페';
      case 'night_market':
        return '야시장';
      case 'leisure':
        return '레저';
      case 'travel':
        return '여행';
      case 'accommodation':
        return '숙박';
      case 'busking':
        return '버스킹';
      case 'festival':
        return '페스티벌';
      default:
        return '기타';
    }
  }

  static String formatKrEnOnPlaceType(String krText) {
    switch (krText) {
      case '식당':
        return 'restaurant';
      case '디저트':
        return 'dessert';
      case '카페':
        return 'cafe';
      case '야시장':
        return 'night_market';
      case '레저':
        return 'leisure';
      case '여행':
        return 'travel';
      case '숙박':
        return 'accommodation';
      case '버스킹':
        return 'busking';
      case '페스티벌':
        return 'festival';
      default:
        return 'etc';
    }
  }
}
