import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ndri_climate/apiservices/advisory.dart';
import 'package:ndri_climate/apiservices/api_provider.dart';
import 'package:ndri_climate/material/plugin/responsiveUtils.dart';
import 'package:ndri_climate/model/utils.dart';

/// A bottom sheet that lets the user type to filter Indian states and pick one.
///
/// Once a state is tapped, it calls:
///   widget.selected_state(chosenState);
///   widget.onStateSelected(chosenState, districtsForThatState);
///
class StateBottomSheet extends StatefulWidget {
  final Function(String) selected_state;
  final Function(String, List<String>) onStateSelected;

  const StateBottomSheet({
    super.key,
    required this.selected_state,
    required this.onStateSelected,
  });

  /// Expose the same map that used to live in the State class, but as a static field
  /// so callers (e.g. Past_Advisories) can do:
  ///   StateBottomSheet.stateDistricts["Punjab"]
  ///
  static const Map<String, List<String>> stateDistricts = {
    'Andhra Pradesh': [
      'Anantapur',
      'Chittoor',
      'East Godavari',
      'Guntur',
      'Krishna',
      'Kurnool',
      'Prakasam',
      'Srikakulam',
      'Sri Potti Sriramulu Nellore',
      'Visakhapatnam',
      'Vizianagaram',
      'West Godavari',
      'YSR Kadapa'
    ],
    'Arunachal Pradesh': [
      'Anjaw',
      'Changlang',
      'Dibang Valley',
      'East Kameng',
      'East Siang',
      'Kamle',
      'Kra Daadi',
      'Kurung Kumey',
      'Lepa Rada',
      'Lohit',
      'Longding',
      'Lower Dibang Valley',
      'Lower Siang',
      'Lower Subansiri',
      'Namsai',
      'Pakke Kessang',
      'Papum Pare',
      'Shi Yomi',
      'Siang',
      'Tawang',
      'Tirap',
      'Upper Siang',
      'Upper Subansiri',
      'West Kameng',
      'West Siang'
    ],
    'Assam': [
      'Baksa',
      'Barpeta',
      'Biswanath',
      'Bongaigaon',
      'Cachar',
      'Charaideo',
      'Chirang',
      'Darrang',
      'Dhemaji',
      'Dhubri',
      'Dibrugarh',
      'Goalpara',
      'Golaghat',
      'Hailakandi',
      'Hojai',
      'Jorhat',
      'Kamrup',
      'Kamrup Metropolitan',
      'Karbi Anglong',
      'Karimganj',
      'Kokrajhar',
      'Lakhimpur',
      'Majuli',
      'Morigaon',
      'Nagaon',
      'Nalbari',
      'Dima Hasao',
      'Sivasagar',
      'Sonitpur',
      'South Salmara-Mankachar',
      'Tinsukia',
      'Udalguri',
      'West Karbi Anglong'
    ],
    'Bihar': [
      'Araria',
      'Arwal',
      'Aurangabad',
      'Banka',
      'Begusarai',
      'Bhagalpur',
      'Bhojpur',
      'Buxar',
      'Darbhanga',
      'East Champaran',
      'Gaya',
      'Gopalganj',
      'Jamui',
      'Jehanabad',
      'Kaimur',
      'Katihar',
      'Khagaria',
      'Kishanganj',
      'Lakhisarai',
      'Madhepura',
      'Madhubani',
      'Munger',
      'Muzaffarpur',
      'Nalanda',
      'Nawada',
      'Patna',
      'Purnia',
      'Rohtas',
      'Saharsa',
      'Samastipur',
      'Saran',
      'Sheikhpura',
      'Sheohar',
      'Sitamarhi',
      'Siwan',
      'Supaul',
      'Vaishali',
      'West Champaran'
    ],
    'Chhattisgarh': [
      'Balod',
      'Baloda Bazar',
      'Balrampur',
      'Bastar',
      'Bemetara',
      'Bijapur',
      'Bilaspur',
      'Dantewada',
      'Dhamtari',
      'Durg',
      'Gariaband',
      'Gaurela-Pendra-Marwahi',
      'Janjgir-Champa',
      'Jashpur',
      'Kabirdham',
      'Kanker',
      'Kondagaon',
      'Korba',
      'Korea',
      'Mahasamund',
      'Mungeli',
      'Narayanpur',
      'Raigarh',
      'Raipur',
      'Rajnandgaon',
      'Sukma',
      'Surajpur',
      'Surguja'
    ],
    'Goa': ['North Goa', 'South Goa'],
    'Gujarat': [
      'Ahmedabad',
      'Amreli',
      'Anand',
      'Aravalli',
      'Banaskantha',
      'Bharuch',
      'Bhavnagar',
      'Botad',
      'Chhota Udepur',
      'Dahod',
      'Dang',
      'Devbhoomi Dwarka',
      'Gandhinagar',
      'Gir Somnath',
      'Jamnagar',
      'Junagadh',
      'Kheda',
      'Kutch',
      'Mahisagar',
      'Mehsana',
      'Morbi',
      'Narmada',
      'Navsari',
      'Panchmahal',
      'Patan',
      'Porbandar',
      'Rajkot',
      'Sabarkantha',
      'Surat',
      'Surendranagar',
      'Tapi',
      'Vadodara',
      'Valsad'
    ],
    'Haryana': [
      'Ambala',
      'Bhiwani',
      'Charkhi Dadri',
      'Faridabad',
      'Fatehabad',
      'Gurugram',
      'Hisar',
      'Jhajjar',
      'Jind',
      'Kaithal',
      'Karnal',
      'Kurukshetra',
      'Mahendragarh',
      'Nuh',
      'Palwal',
      'Panchkula',
      'Panipat',
      'Rewari',
      'Rohtak',
      'Sirsa',
      'Sonipat',
      'Yamunanagar'
    ],
    'Himachal Pradesh': [
      'Bilaspur',
      'Chamba',
      'Hamirpur',
      'Kangra',
      'Kinnaur',
      'Kullu',
      'Lahaul and Spiti',
      'Mandi',
      'Shimla',
      'Sirmaur',
      'Solan',
      'Una'
    ],
    'Jharkhand': [
      'Bokaro',
      'Chatra',
      'Deoghar',
      'Dhanbad',
      'Dumka',
      'East Singhbhum',
      'Garhwa',
      'Giridih',
      'Godda',
      'Gumla',
      'Hazaribagh',
      'Jamtara',
      'Khunti',
      'Koderma',
      'Latehar',
      'Lohardaga',
      'Pakur',
      'Palamu',
      'Ramgarh',
      'Ranchi',
      'Sahebganj',
      'Seraikela Kharsawan',
      'Simdega',
      'West Singhbhum'
    ],
    'Karnataka': [
      'Bagalkot',
      'Ballari',
      'Belagavi',
      'Bengaluru Rural',
      'Bengaluru Urban',
      'Bidar',
      'Chamarajanagar',
      'Chikballapur',
      'Chikkamagaluru',
      'Chitradurga',
      'Dakshina Kannada',
      'Davanagere',
      'Dharwad',
      'Gadag',
      'Hassan',
      'Haveri',
      'Kalaburagi',
      'Kodagu',
      'Kolar',
      'Koppal',
      'Mandya',
      'Mysuru',
      'Raichur',
      'Ramanagara',
      'Shivamogga',
      'Tumakuru',
      'Udupi',
      'Uttara Kannada',
      'Vijayapura',
      'Yadgir'
    ],
    'Kerala': [
      'Alappuzha',
      'Ernakulam',
      'Idukki',
      'Kannur',
      'Kasaragod',
      'Kollam',
      'Kottayam',
      'Kozhikode',
      'Malappuram',
      'Palakkad',
      'Pathanamthitta',
      'Thiruvananthapuram',
      'Thrissur',
      'Wayanad'
    ],
    'Madhya Pradesh': [
      'Agar Malwa',
      'Alirajpur',
      'Anuppur',
      'Ashoknagar',
      'Balaghat',
      'Barwani',
      'Betul',
      'Bhind',
      'Bhopal',
      'Burhanpur',
      'Chachaura',
      'Chhatarpur',
      'Chhindwara',
      'Damoh',
      'Datia',
      'Dewas',
      'Dhar',
      'Dindori',
      'Guna',
      'Gwalior',
      'Harda',
      'Hoshangabad',
      'Indore',
      'Jabalpur',
      'Jhabua',
      'Katni',
      'Khandwa',
      'Khargone',
      'Mandla',
      'Mandsaur',
      'Morena',
      'Narsinghpur',
      'Neemuch',
      'Niwari',
      'Panna',
      'Raisen',
      'Rajgarh',
      'Ratlam',
      'Rewa',
      'Sagar',
      'Satna',
      'Sehore',
      'Seoni',
      'Shahdol',
      'Shajapur',
      'Sheopur',
      'Shivpuri',
      'Sidhi',
      'Singrauli',
      'Tikamgarh',
      'Ujjain',
      'Umaria',
      'Vidisha'
    ],
    'Maharashtra': [
      'Ahmednagar',
      'Akola',
      'Amravati',
      'Aurangabad',
      'Beed',
      'Bhandara',
      'Buldhana',
      'Chandrapur',
      'Dhule',
      'Gadchiroli',
      'Gondia',
      'Hingoli',
      'Jalgaon',
      'Jalna',
      'Kolhapur',
      'Latur',
      'Mumbai City',
      'Mumbai Suburban',
      'Nagpur',
      'Nanded',
      'Nandurbar',
      'Nashik',
      'Osmanabad',
      'Palghar',
      'Parbhani',
      'Pune',
      'Raigad',
      'Ratnagiri',
      'Sangli',
      'Satara',
      'Sindhudurg',
      'Solapur',
      'Thane',
      'Wardha',
      'Washim',
      'Yavatmal'
    ],
    'Manipur': [
      'Bishnupur',
      'Chandel',
      'Churachandpur',
      'Imphal East',
      'Imphal West',
      'Jiribam',
      'Kakching',
      'Kamjong',
      'Kangpokpi',
      'Noney',
      'Pherzawl',
      'Senapati',
      'Tamenglong',
      'Tengnoupal',
      'Thoubal',
      'Ukhrul'
    ],
    'Meghalaya': [
      'East Garo Hills',
      'East Jaintia Hills',
      'East Khasi Hills',
      'North Garo Hills',
      'Ri Bhoi',
      'South Garo Hills',
      'South West Garo Hills',
      'South West Khasi Hills',
      'West Garo Hills',
      'West Jaintia Hills',
      'West Khasi Hills'
    ],
    'Mizoram': [
      'Aizawl',
      'Champhai',
      'Hnahthial',
      'Khawzawl',
      'Kolasib',
      'Lawngtlai',
      'Lunglei',
      'Mamit',
      'Saiha',
      'Serchhip',
      'Saitual'
    ],
    'Nagaland': [
      'Chumoukedima',
      'Dimapur',
      'Kiphire',
      'Kohima',
      'Longleng',
      'Mokokchung',
      'Mon',
      'Noklak',
      'Peren',
      'Phek',
      'Tuensang',
      'Wokha',
      'Zunheboto'
    ],
    'Odisha': [
      'Angul',
      'Balangir',
      'Balasore',
      'Bargarh',
      'Bhadrak',
      'Boudh',
      'Cuttack',
      'Deogarh',
      'Dhenkanal',
      'Gajapati',
      'Ganjam',
      'Jagatsinghpur',
      'Jajpur',
      'Jharsuguda',
      'Kalahandi',
      'Kandhamal',
      'Kendrapara',
      'Kendujhar',
      'Khordha',
      'Koraput',
      'Malkangiri',
      'Mayurbhanj',
      'Nabarangpur',
      'Nayagarh',
      'Nuapada',
      'Puri',
      'Rayagada',
      'Sambalpur',
      'Subarnapur',
      'Sundergarh'
    ],
    'Punjab': [
      'Amritsar',
      'Barnala',
      'Bathinda',
      'Faridkot',
      'Fatehgarh Sahib',
      'Fazilka',
      'Ferozepur',
      'Gurdaspur',
      'Hoshiarpur',
      'Jalandhar',
      'Kapurthala',
      'Ludhiana',
      'Malerkotla',
      'Mansa',
      'Moga',
      'Mohali',
      'Muktsar',
      'Pathankot',
      'Patiala',
      'Rupnagar',
      'Sangrur',
      'Shaheed Bhagat Singh Nagar',
      'Tarn Taran'
    ],
    'Rajasthan': [
      'Ajmer',
      'Alwar',
      'Banswara',
      'Baran',
      'Barmer',
      'Bharatpur',
      'Bhilwara',
      'Bikaner',
      'Bundi',
      'Chittorgarh',
      'Churu',
      'Dausa',
      'Dholpur',
      'Dungarpur',
      'Hanumangarh',
      'Jaipur',
      'Jaisalmer',
      'Jalore',
      'Jhalawar',
      'Jhunjhunu',
      'Jodhpur',
      'Karauli',
      'Kota',
      'Nagaur',
      'Pali',
      'Pratapgarh',
      'Rajsamand',
      'Sawai Madhopur',
      'Sikar',
      'Sirohi',
      'Sri Ganganagar',
      'Tonk',
      'Udaipur'
    ],
    'Sikkim': ['East Sikkim', 'North Sikkim', 'South Sikkim', 'West Sikkim'],
    'Tamil Nadu': [
      'Ariyalur',
      'Chengalpattu',
      'Chennai',
      'Coimbatore',
      'Cuddalore',
      'Dharmapuri',
      'Dindigul',
      'Erode',
      'Kallakurichi',
      'Kancheepuram',
      'Karur',
      'Krishnagiri',
      'Madurai',
      'Nagapattinam',
      'Kanyakumari',
      'Namakkal',
      'Nilgiris',
      'Perambalur',
      'Pudukkottai',
      'Ramanathapuram',
      'Ranipet',
      'Salem',
      'Sivaganga',
      'Tenkasi',
      'Thanjavur',
      'Theni',
      'Thoothukudi',
      'Tiruchirappalli',
      'Tirunelveli',
      'Tirupattur',
      'Tiruppur',
      'Tiruvallur',
      'Tiruvannamalai',
      'Tiruvarur',
      'Vellore',
      'Viluppuram',
      'Virudhunagar'
    ],
    'Telangana': [
      'Adilabad',
      'Bhadradri Kothagudem',
      'Hyderabad',
      'Jagtial',
      'Jangaon',
      'Jayashankar Bhupalpally',
      'Jogulamba Gadwal',
      'Kamareddy',
      'Karimnagar',
      'Khammam',
      'Kumuram Bheem Asifabad',
      'Mahabubabad',
      'Mahabubnagar',
      'Mancherial',
      'Medak',
      'Medchal-Malkajgiri',
      'Mulugu',
      'Nagarkurnool',
      'Nalgonda',
      'Narayanpet',
      'Nirmal',
      'Nizamabad',
      'Peddapalli',
      'Rajanna Sircilla',
      'Ranga Reddy',
      'Sangareddy',
      'Siddipet',
      'Suryapet',
      'Vikarabad',
      'Wanaparthy',
      'Warangal Rural',
      'Warangal Urban',
      'Yadadri Bhuvanagiri'
    ],
    'Tripura': [
      'Dhalai',
      'Gomati',
      'Khowai',
      'North Tripura',
      'Sepahijala',
      'South Tripura',
      'Unakoti',
      'West Tripura'
    ],
    'Uttar Pradesh': [
      'Agra',
      'Aligarh',
      'Ambedkar Nagar',
      'Amethi',
      'Amroha',
      'Auraiya',
      'Ayodhya',
      'Azamgarh',
      'Badaun',
      'Baghpat',
      'Bahraich',
      'Ballia',
      'Balrampur',
      'Banda',
      'Barabanki',
      'Bareilly',
      'Basti',
      'Bhadohi',
      'Bijnor',
      'Bulandshahr',
      'Chandauli',
      'Chitrakoot',
      'Deoria',
      'Etah',
      'Etawah',
      'Farrukhabad',
      'Fatehpur',
      'Firozabad',
      'Gautam Buddha Nagar',
      'Ghaziabad',
      'Ghazipur',
      'Gonda',
      'Gorakhpur',
      'Hamirpur',
      'Hapur',
      'Hardoi',
      'Hathras',
      'Jalaun',
      'Jaunpur',
      'Jhansi',
      'Kannauj',
      'Kanpur Dehat',
      'Kanpur Nagar',
      'Kasganj',
      'Kaushambi',
      'Kheri',
      'Kushinagar',
      'Lalitpur',
      'Lucknow',
      'Maharajganj',
      'Mahoba',
      'Mainpuri',
      'Mathura',
      'Mau',
      'Meerut',
      'Mirzapur',
      'Moradabad',
      'Muzaffarnagar',
      'Pilibhit',
      'Pratapgarh',
      'Prayagraj',
      'Rae Bareli',
      'Rampur',
      'Saharanpur',
      'Sambhal',
      'Sant Kabir Nagar',
      'Shahjahanpur',
      'Shamli',
      'Shrawasti',
      'Siddharthnagar',
      'Sitapur',
      'Sonbhadra',
      'Sultanpur',
      'Unnao',
      'Varanasi'
    ],
    'Uttarakhand': [
      'Almora',
      'Bageshwar',
      'Chamoli',
      'Champawat',
      'Dehradun',
      'Haridwar',
      'Nainital',
      'Pauri Garhwal',
      'Pithoragarh',
      'Rudraprayag',
      'Tehri Garhwal',
      'Udham Singh Nagar',
      'Uttarkashi'
    ],
    'West Bengal': [
      'Alipurduar',
      'Bankura',
      'Birbhum',
      'Cooch Behar',
      'Dakshin Dinajpur',
      'Darjeeling',
      'Hooghly',
      'Howrah',
      'Jalpaiguri',
      'Jhargram',
      'Kalimpong',
      'Kolkata',
      'Malda',
      'Murshidabad',
      'Nadia',
      'North 24 Parganas',
      'Paschim Bardhaman',
      'Paschim Medinipur',
      'Purba Bardhaman',
      'Purba Medinipur',
      'Purulia',
      'South 24 Parganas',
      'Uttar Dinajpur'
    ],
    'Andaman and Nicobar Islands': [
      'Nicobar',
      'North and Middle Andaman',
      'South Andaman'
    ],
    'Chandigarh': ['Chandigarh'],
    'Dadra and Nagar Haveli and Daman and Diu': [
      'Dadra and Nagar Haveli',
      'Daman',
      'Diu'
    ],
    'Delhi': [
      'Central Delhi',
      'East Delhi',
      'New Delhi',
      'North Delhi',
      'North East Delhi',
      'North West Delhi',
      'Shahdara',
      'South Delhi',
      'South East Delhi',
      'South West Delhi',
      'West Delhi'
    ],
    'Lakshadweep': ['Lakshadweep'],
    'Puducherry': ['Karaikal', 'Mahe', 'Puducherry', 'Yanam'],
    'Jammu and Kashmir': [
      'Anantnag',
      'Bandipora',
      'Baramulla',
      'Budgam',
      'Doda',
      'Ganderbal',
      'Jammu',
      'Kathua',
      'Kishtwar',
      'Kulgam',
      'Kupwara',
      'Poonch',
      'Pulwama',
      'Rajouri',
      'Ramban',
      'Reasi',
      'Samba',
      'Shopian',
      'Srinagar',
      'Udhampur'
    ],
    'Ladakh': ['Kargil', 'Leh']
  };

  @override
  _StateBottomSheetState createState() => _StateBottomSheetState();
}

class _StateBottomSheetState extends State<StateBottomSheet> {
  TextEditingController searchController = TextEditingController();
  List<String> indianStates = const [
    'Andaman and Nicobar Islands',
    'Andhra Pradesh',
    'Arunachal Pradesh',
    'Assam',
    'Bihar',
    'Chandigarh',
    'Chhattisgarh',
    'Dadra and Nagar Haveli and Daman and Diu',
    'Delhi',
    'Goa',
    'Gujarat',
    'Haryana',
    'Himachal Pradesh',
    'Jammu and Kashmir',
    'Jharkhand',
    'Karnataka',
    'Kerala',
    'Ladakh',
    'Lakshadweep',
    'Madhya Pradesh',
    'Maharashtra',
    'Manipur',
    'Meghalaya',
    'Mizoram',
    'Nagaland',
    'Odisha',
    'Puducherry',
    'Punjab',
    'Rajasthan',
    'Sikkim',
    'Tamil Nadu',
    'Telangana',
    'Tripura',
    'Uttar Pradesh',
    'Uttarakhand',
    'West Bengal'
  ];
  List<String> filteredStates = [];

  @override
  void initState() {
    super.initState();
    filteredStates = List.from(indianStates);
  }

  void filterStates(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredStates = indianStates
          .where((s) => s.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0, left: 0, right: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color(0xFF2C96D2),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Please Select One'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Type your State'.tr,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: filterStates,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: filteredStates.length,
              itemBuilder: (context, index) {
                final stateName = filteredStates[index];
                return ListTile(
                  title: Text(stateName.tr),
                  onTap: () {
                    final districtsList =
                        StateBottomSheet.stateDistricts[stateName] ?? [];
                    widget.selected_state(stateName.tr);
                    widget.onStateSelected(stateName, districtsList);
                    Navigator.pop(context, stateName);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A bottom sheet that lets the user filter among a given list of districts.
class DistrictBottomSheet extends StatefulWidget {
  final Function(String) selected_district;
  final List<String> districts;

  const DistrictBottomSheet({
    super.key,
    required this.selected_district,
    required this.districts,
  });

  @override
  _DistrictBottomSheetState createState() => _DistrictBottomSheetState();
}

class _DistrictBottomSheetState extends State<DistrictBottomSheet> {
  TextEditingController searchController = TextEditingController();
  late List<String> districts_list;
  late List<String> filteredDistricts;

  @override
  void initState() {
    super.initState();
    districts_list = widget.districts;
    filteredDistricts = List.from(districts_list);
  }

  void filterDistricts(String query) {
    query = query.toLowerCase();
    setState(() {
      filteredDistricts = districts_list
          .where((d) => d.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0, left: 0, right: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color(0xFF2C96D2),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Please Select One'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Type your District'.tr,
                prefixIcon: const Icon(Icons.search),
                border: const OutlineInputBorder(),
              ),
              onChanged: filterDistricts,
            ),
          ),
          const SizedBox(height: 16.0),
          Expanded(
            child: ListView.builder(
              itemCount: filteredDistricts.length,
              itemBuilder: (context, index) {
                final districtName = filteredDistricts[index];
                return ListTile(
                  title: Text(districtName.tr),
                  onTap: () {
                    widget.selected_district(districtName.tr);
                    Navigator.pop(context, districtName);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// A bottom sheet for language selection (Hindi, English, Punjabi, Bengali).
class LanguageBottomSheet extends StatefulWidget {
  final Function(String) selected_language;

  const LanguageBottomSheet({super.key, required this.selected_language});

  @override
  State<LanguageBottomSheet> createState() => _LanguageBottomSheetState();
}

class _LanguageBottomSheetState extends State<LanguageBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color(0xFF2C96D2),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Please Select One'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 18),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          ListTile(
            title: Text('Hindi'.tr),
            onTap: () {
              var locale = const Locale('hi', 'IN');
              Get.updateLocale(locale);
              widget.selected_language('Hindi');
              Navigator.pop(context, 'Hindi');
            },
          ),
          ListTile(
            title: Text('English'.tr),
            onTap: () {
              var locale = const Locale('en', 'US');
              Get.updateLocale(locale);
              widget.selected_language('English');
              Navigator.pop(context, 'English');
            },
          ),
          ListTile(
            title: Text('Punjabi'.tr),
            onTap: () {
              var locale = const Locale('pa', 'IN');
              Get.updateLocale(locale);
              widget.selected_language('Punjabi');
              Navigator.pop(context, 'Punjabi');
            },
          ),
          ListTile(
            title: Text('Bengali'.tr),
            onTap: () {
              var locale = const Locale('bn', 'IN');
              Get.updateLocale(locale);
              widget.selected_language('Bengali');
              Navigator.pop(context, 'Bengali');
            },
          ),
        ],
      ),
    );
  }
}

/// A bottom sheet that shows all advisories, letting the user tap one date‐range to filter.
/// You’ll need to call fetchAdvisory(...) elsewhere to get `allData`.
class filterDate extends StatefulWidget {
  final Function(DateTime, DateTime, int) onTapcallback;
  final int index;

  filterDate({
    super.key,
    required this.onTapcallback,
    required this.index,
  });

  @override
  State<filterDate> createState() => _filterDateState();
}

class _filterDateState extends State<filterDate> {
  int _selecteDate = 0;

  @override
  void initState() {
    super.initState();
    _selecteDate = widget.index;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 16.0, left: 0, right: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20), topRight: Radius.circular(20)),
              color: Color(0xFF2C96D2),
            ),
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Choose One'.tr,
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 250,
            child: FutureBuilder<List<Advisory>>(
              future: ApiProvider().fetchAdvisory(
                state: '',     // You can pass a default or real state if needed
                district: '',  // Pass a default or real district if needed
              ),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Container(
                    height: MediaQuery.of(context).size.height / 2,
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator.adaptive(),
                  );
                }
                if (snapshot.hasData) {
                  final advisory_data = snapshot.data!.reversed.toList();
                  return ListView.builder(
                    itemCount: advisory_data.length,
                    itemBuilder: (context, index) {
                      final adv = advisory_data[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: RadioListTile<int>(
                          activeColor: const Color(0xFF2C96D2),
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.black26),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          controlAffinity: ListTileControlAffinity.trailing,
                          title: Row(
                            children: [
                              Chip(
                                backgroundColor:
                                (_selecteDate == index) ? const Color(0xFF2C96D2) : Colors.white,
                                label: Text(
                                  formatDate(inputDate: adv.fromDate.toString()) +
                                      ' → ' +
                                      formatDate(inputDate: adv.toDate.toString()),
                                  style: TextStyle(
                                    color: (_selecteDate == index) ? Colors.white : Colors.black,
                                    fontSize: ResponsiveUtils.wp(2.5),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          value: index,
                          groupValue: _selecteDate,
                          onChanged: (value) {
                            setState(() {
                              _selecteDate = value!;
                            });
                            widget.onTapcallback(adv.fromDate, adv.toDate, _selecteDate);
                          },
                        ),
                      );
                    },
                  );
                }
                return Container(
                  alignment: Alignment.center,
                  child: const SizedBox(
                    height: 40,
                    width: 40,
                    child: CircularProgressIndicator(color: Colors.blueAccent),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
