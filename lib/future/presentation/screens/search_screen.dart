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

  List<DictionaryEntity> words = [];

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final dict = BlocProvider.of<SearchDictionaryCubit>(context);

    print('build ${words.length} $words');

    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.only(topRight: Radius.circular(20), topLeft: Radius.circular(20)),
      ),
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
              pinned: true,
              // snap: true,
              // floating: false,
              backgroundColor: Theme.of(context).primaryColor, //Colors.orange,
              title: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3.0),
                width: double.infinity,
                child: Text(
                  'Search words',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      ?.copyWith(color: Colors.white, letterSpacing: 1.2, fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              bottom: PreferredSize(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 5.0),
                      decoration: BoxDecoration(
                        border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor)),
                        // color: Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(16.0),
                          ),
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
                            placeholder: '',
                            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
                            prefixInsets: const EdgeInsets.only(left: 20),
                            suffixInsets: const EdgeInsets.only(right: 20),
                            backgroundColor: Theme.of(context).primaryColor,
                            borderRadius: BorderRadius.circular(16.0),
                            itemColor: CupertinoColors.systemBackground,
                            autofocus: true,
                            style: Theme.of(context).textTheme.headline3?.copyWith(
                                  color: CupertinoColors.systemBackground,
                                  letterSpacing: 1.2,
                                  decoration: TextDecoration.none,
                                  decorationColor: Colors.transparent,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                preferredSize: const Size.fromHeight(40),
              )),
          SliverFixedExtentList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return _buildCustomRowItem(words[index]);
              },
              childCount: words.length,
            ),
            itemExtent: 60,
          ),
        ],
      ),
    );
  }

  Widget _buildCustomRowItem(DictionaryEntity item) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 2).copyWith(top: 0),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Theme.of(context).primaryColor, width: 0.2)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Icon(Icons.search, color: Theme.of(context).primaryColor),
          ),
          const SizedBox(width: 12),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(item.word,
                      style: Theme.of(context).textTheme.headline3?.copyWith(color: Colors.black87.withOpacity(0.7))),
                  const SizedBox(width: 8),
                  Text(
                    item.transcription,
                    style: Theme.of(context).textTheme.bodyText1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(item.translation),
            ],
          ),
          const Spacer(),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton(
              onPressed: () {},
              child: Text(
                'Add',
                style: Theme.of(context).textTheme.headline3?.copyWith(color: Theme.of(context).primaryColor),
              ),
              style: ButtonStyle(
                side: MaterialStateProperty.all(BorderSide(color: Theme.of(context).primaryColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
