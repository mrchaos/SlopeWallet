class WalletBean {
    String balance;
    String icon;
    String name;
    String thumbAddress;
    String usd;

  WalletBean({
    this.balance = '',
    this.icon = '',
    this.name = '',
    this.thumbAddress = '',
    this.usd = '',
  });

  factory WalletBean.fromJson(Map<String, dynamic> json) {
        return WalletBean(
            balance: json['balance'], 
            icon: json['icon'], 
            name: json['name'], 
            thumbAddress: json['thumbAddress'], 
            usd: json['usd'], 
        );
    }

    Map<String, dynamic> toJson() {
        final Map<String, dynamic> data = new Map<String, dynamic>();
        data['balance'] = this.balance;
        data['icon'] = this.icon;
        data['name'] = this.name;
        data['thumbAddress'] = this.thumbAddress;
        data['usd'] = this.usd;
        return data;
    }
}