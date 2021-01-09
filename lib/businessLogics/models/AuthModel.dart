class AuthData {
  String email;
  String password;
  AuthData(this.email, this.password);
}



    // Consumer<MarketViewModel>(builder: (_, _value, __) {
    //         return Column(
    //           crossAxisAlignment: CrossAxisAlignment.start,
    //           children: [
    //             Row(
    //               children: [
    //                 Text(
    //                   'Select Lorry ',
    //                   style: TextStyle(
    //                     fontWeight: FontWeight.w600,
    //                   ),
    //                 ),
    //                 Text(
    //                   _value.selectedList.isEmpty ? 'required' : '',
    //                   style: TextStyle(
    //                       fontWeight: FontWeight.w600, color: Colors.red),
    //                 )
    //               ],
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Container(
    //               height: 80,
    //               child: ListView.builder(
    //                 itemCount: _value.truckList.length,
    //                 scrollDirection: Axis.horizontal,
    //                 itemBuilder: (context, index) {
    //                   return Padding(
    //                     padding: const EdgeInsets.all(5.0),
    //                     child: Container(
    //                       decoration: BoxDecoration(
    //                           borderRadius: BorderRadius.circular(5),
    //                           color: Colors.grey.shade300,
    //                           border: Border.all(
    //                             width: 2,
    //                             color: (_value.selectedList.contains(index))
    //                                 ? Colors.blue
    //                                 : Colors.transparent,
    //                           )),
    //                       child: InkWell(
    //                         onTap: () {
    //                           if (!_value.selectedList.contains(index)) {
    //                             _value.selectedList.clear();
    //                             _value.selectedList = index;
    //                           }
    //                         },
    //                         child: Column(
    //                           children: [
    //                             Text(_value.truckList[index]),
    //                             Container(
    //                               width: 70,
    //                             ),
    //                           ],
    //                         ),
    //                       ),
    //                     ),
    //                   );
    //                 },
    //               ),
    //             ),
    //           ],
    //         );
    //       }),
      