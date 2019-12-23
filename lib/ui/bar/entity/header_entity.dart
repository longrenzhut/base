class HeaderEntity {
	List<HeaderTypeinfo> typeInfo;
	int headlineCount;
	List<HeaderBannerinfo> bannerInfo;
	int bannerCount;
	List<HeaderHeadlineinfo> headlineInfo;

	HeaderEntity({this.typeInfo, this.headlineCount, this.bannerInfo, this.bannerCount, this.headlineInfo});

	HeaderEntity.fromJson(Map<String, dynamic> json) {
		if (json['typeInfo'] != null) {
			typeInfo = new List<HeaderTypeinfo>();(json['typeInfo'] as List).forEach((v) { typeInfo.add(new HeaderTypeinfo.fromJson(v)); });
		}
		headlineCount = json['headlineCount'];
		if (json['bannerInfo'] != null) {
			bannerInfo = new List<HeaderBannerinfo>();(json['bannerInfo'] as List).forEach((v) { bannerInfo.add(new HeaderBannerinfo.fromJson(v)); });
		}
		bannerCount = json['bannerCount'];
		if (json['headlineInfo'] != null) {
			headlineInfo = new List<HeaderHeadlineinfo>();(json['headlineInfo'] as List).forEach((v) { headlineInfo.add(new HeaderHeadlineinfo.fromJson(v)); });
		}
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		if (this.typeInfo != null) {
      data['typeInfo'] =  this.typeInfo.map((v) => v.toJson()).toList();
    }
		data['headlineCount'] = this.headlineCount;
		if (this.bannerInfo != null) {
      data['bannerInfo'] =  this.bannerInfo.map((v) => v.toJson()).toList();
    }
		data['bannerCount'] = this.bannerCount;
		if (this.headlineInfo != null) {
      data['headlineInfo'] =  this.headlineInfo.map((v) => v.toJson()).toList();
    }
		return data;
	}
}

class HeaderTypeinfo {
	String typeName;
	String typeIcon;
	int typeId;

	HeaderTypeinfo({this.typeName, this.typeIcon, this.typeId});

	HeaderTypeinfo.fromJson(Map<String, dynamic> json) {
		typeName = json['typeName'];
		typeIcon = json['typeIcon'];
		typeId = json['typeId'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['typeName'] = this.typeName;
		data['typeIcon'] = this.typeIcon;
		data['typeId'] = this.typeId;
		return data;
	}
}

class HeaderBannerinfo {
	String imageWidth;
	int bannerId;
	String imageUrl;
	String url;
	String imageHeight;

	HeaderBannerinfo({this.imageWidth, this.bannerId, this.imageUrl, this.url, this.imageHeight});

	HeaderBannerinfo.fromJson(Map<String, dynamic> json) {
		imageWidth = json['imageWidth'];
		bannerId = json['bannerId'];
		imageUrl = json['imageUrl'];
		url = json['url'];
		imageHeight = json['imageHeight'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['imageWidth'] = this.imageWidth;
		data['bannerId'] = this.bannerId;
		data['imageUrl'] = this.imageUrl;
		data['url'] = this.url;
		data['imageHeight'] = this.imageHeight;
		return data;
	}
}

class HeaderHeadlineinfo {
	int headlineId;
	String title;

	HeaderHeadlineinfo({this.headlineId, this.title});

	HeaderHeadlineinfo.fromJson(Map<String, dynamic> json) {
		headlineId = json['headlineId'];
		title = json['title'];
	}

	Map<String, dynamic> toJson() {
		final Map<String, dynamic> data = new Map<String, dynamic>();
		data['headlineId'] = this.headlineId;
		data['title'] = this.title;
		return data;
	}
}
