import 'package:apitestflutter/features/home/presentation/widgets/post_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../models/post.dart';
import '../viewmodels/home_view_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  void initState() {
    super.initState();
    // Load posts when the page is initialized
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeViewModel>().loadPosts();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (context, viewModel, child) {
        return CupertinoPageScaffold(
          child: CustomScrollView(
            slivers: [
              CupertinoSliverNavigationBar(
                largeTitle: const Text('Home'),
                border: null,
                automaticallyImplyLeading: false,
              ),
              if (viewModel.isLoading && viewModel.posts.isEmpty)
                const SliverToBoxAdapter(
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(20.0),
                      child: CupertinoActivityIndicator(),
                    ),
                  ),
                )
              else
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      if (index >= viewModel.posts.length) {
                        if (viewModel.hasMorePosts && !viewModel.isLoading) {
                          viewModel.loadMorePosts();
                        }
                        return null;
                      }
                      return _buildPostRow(viewModel.posts[index]);
                    },
                    childCount: viewModel.posts.length + (viewModel.hasMorePosts ? 1 : 0),
                  ),
                ),
              // Add bottom padding to prevent last item from being hidden under tab bar
              const SliverToBoxAdapter(
                child: SizedBox(height: 100),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostRow(Post post) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppConstants.defaultPadding),
        child: PostRow(post: post),
      ),
    );
  }
}
