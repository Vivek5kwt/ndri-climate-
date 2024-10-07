// class Advisory {
//   final int id;
//   final String title;
//   final String description;
//   final DateTime fromDate;
//   final DateTime toDate;
//   final DateTime date;
//   final DateTime createdAt;
//   final DateTime updatedAt;

//   Advisory({
//     required this.id,
//     required this.title,
//     required this.description,
//     required this.fromDate,
//     required this.toDate,
//     required this.date,
//     required this.createdAt,
//     required this.updatedAt,
//   });

//   factory Advisory.fromJson(Map<String, dynamic> json) {
//     return Advisory(
//       id: json['id'],
//       title: json['title'],
//       description: json['description'],
//       fromDate: DateTime.parse(json['from_date']),
//       toDate: DateTime.parse(json['to_date']),
//       date: DateTime.parse(json['date']),
//       createdAt: DateTime.parse(json['created_at']),
//       updatedAt: DateTime.parse(json['updated_at']),
//     );
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'from_date': fromDate.toIso8601String(),
//       'to_date': toDate.toIso8601String(),
//       'date': date.toIso8601String(),
//       'created_at': createdAt.toIso8601String(),
//       'updated_at': updatedAt.toIso8601String(),
//     };
//   }
// }

class Advisory {
 final int id;
 final String title;
 final DateTime fromDate;
 final DateTime toDate;
 final DateTime date;
 final DateTime createdAt;
 final DateTime updatedAt;
 final String descriptionEn;
 final String descriptionPa;
 final String descriptionHi;
 final String descriptionBn;

  Advisory(
      {required this.id,
      required this.title,
      required this.fromDate,
      required this.toDate,
      required this.date,
      required this.createdAt,
      required this.updatedAt,
      required this.descriptionEn,
      required this.descriptionPa,
      required this.descriptionHi,
      required this.descriptionBn});

  factory Advisory.fromJson(Map<String, dynamic> json) {
    return Advisory(
      id: json['id'],
      title: json['title'],
      fromDate: DateTime.parse(json['from_date']),
      toDate: DateTime.parse(json['to_date']),
      date: DateTime.parse(json['date']),
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      descriptionEn: json['description_en'],
      descriptionPa: json['description_pa'],
      descriptionHi: json['description_hi'],
      descriptionBn: json['description_bn']
    
    );
  }

  Map<String, dynamic> toJson() {

    return{
      'id':id,
      'title':title,
      'descriptionBn':descriptionBn,
      'descriptionEn':descriptionEn,
      'descriptionHi':descriptionHi,
      'descriptionPa':descriptionPa,
      'fromDate':fromDate.toIso8601String(),
      'toDate':toDate.toIso8601String(),
      'date':date.toIso8601String(),
      'createdAt':createdAt.toIso8601String(),
      'updatedAt':updatedAt.toIso8601String(),



    };
  }
}