class ServiceItem {
  String title;
  String description;
  String image;

  ServiceItem(
      {required this.title, required this.description, required this.image});
}

var ServiceItemDatas = [
  ServiceItem(
      title: "User to User marquet",
      description: "Votre application d'échange de jouets",
      image: "assets/images/svg/market.svg"),
  ServiceItem(
      title: "Paiement rapide et sécurisé",
      description: "Votre application d'échange de jouets",
      image: "assets/images/svg/payement.svg"),
  ServiceItem(
      title: "Chat  avec le propriétère",
      description: "Votre application d'échange de jouets",
      image: "assets/images/svg/chat.svg"),
];
