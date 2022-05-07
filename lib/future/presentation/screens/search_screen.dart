import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:word_notifier/future/domain/entities/dictionary_entity.dart';
import 'package:word_notifier/future/presentation/bloc/dictionary/search_dictionary_cubit.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  late TextEditingController _textController;

  // List<DictionaryEntity> dict = [];
  List<DictionaryEntity> words = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();

    // dict = await dictCubit.search('');
  }

  @override
  Widget build(BuildContext context) {
    final dict = BlocProvider.of<SearchDictionaryCubit>(context);

    print('build ${words.length} $words');

    return CustomScrollView(
      slivers: [
        SliverAppBar(
            pinned: true,
            // snap: true,
            // floating: false,
            backgroundColor: Colors.orange,
            title: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
              width: double.infinity,
              child: const Text(
                'Search words',
                style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            bottom: PreferredSize(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                decoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.orange)),
                  color: Colors.transparent,
                ),
                child: Align(
                  alignment: Alignment.topCenter,
                  child: CupertinoSearchTextField(
                    controller: _textController,
                    onChanged: (String value) async {
                      print('value = $value');
                      if (value.isEmpty || value.length < 2) {
                        setState(() {
                          words = [];
                        });
                        return;
                      }
                      words = await dict.search(value);
                      print('onChange $words');
                      setState(() {});
                    },
                    onSuffixTap: () {
                      setState(() {
                        _textController.text = '';
                        words = [];
                      });
                    },
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                    prefixInsets: const EdgeInsets.only(left: 20),
                    suffixInsets: const EdgeInsets.only(right: 20),
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                  ),
                ),
              ),
              preferredSize: const Size.fromHeight(50),
            )),
        // SliverAppBar(preferredSize: const Size.fromHeight(5),),
        SliverFixedExtentList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return _buildRowItem(words[index]);
            },
            childCount: words.length,
          ),
          itemExtent: 58,
        ),
      ],
      // appBar: AppBar(
      //   centerTitle: true,
      //   title: const Text('Wordify'),
      //   elevation: 1,
      //   backgroundColor: Colors.orange,
      //   toolbarHeight: 110,
      //
      // ),

/*      appBar: PreferredSize(
        preferredSize: const Size(double.infinity, kToolbarHeight*2),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.orange)),
            color: Colors.orange,
          ),
          child: Align(
            alignment: Alignment.bottomCenter,
            child: CupertinoSearchTextField(
              controller: _textController,
              onChanged: (String value) async {
                print('value = $value');
                if (value.isEmpty || value.length < 2) {
                  setState(() {
                    words = [];
                  });
                  return;
                }
                words = await dict.search(value);
                print('onChange $words');
                setState(() {});
              },
              onSuffixTap: () {
                setState(() {
                  _textController.text = '';
                  words = [];
                });
              },
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              prefixInsets: const EdgeInsets.only(left: 20),
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(16.0),
              ),
            ),
          ),
        ),
      ),*/

/*      body: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: words.length,
                itemBuilder: (context, index) => _buildRowItem(words[index]),
              ),
            ),
            // Expanded(
            //   child: SingleChildScrollView(
            //     child: Column(
            //       children: words.map((item) => _buildRowItem(item)).toList(),
            //     ),
            //   ),
            // )
          ],
        ),
      ),*/
    );
  }

  Widget _buildRowItem(DictionaryEntity item) {
    return Container(
      // height: 30,
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.orange, width: 1.5),
          color: Colors.orange.shade50,
          boxShadow: [
            BoxShadow(
              color: Colors.orange.shade400,
              // spreadRadius: 1.0,
              blurRadius: 1.0,
              offset: Offset(1.0, 1.0),
            )
          ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    item.word,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    item.transcription,
                    style: const TextStyle(fontSize: 13),
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(item.translation),
            ],
          ),
          ElevatedButton(
              onPressed: () {},
              child: Text('Add'),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.orange))),
        ],
      ),
    );
  }
}
