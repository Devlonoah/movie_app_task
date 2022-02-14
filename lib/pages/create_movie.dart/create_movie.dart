import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import '../../bloc/form_bloc/validation_state.dart';
import '../../bloc/movie_crud/movie_crud_bloc.dart';
import '../../bloc/movie_form/image_field/image_field_bloc.dart';
import '../../bloc/movie_form/movie_form/movie_form_bloc.dart';
import '../../bloc/movie_form/publish_year_field/publish_year_bloc.dart';
import '../../bloc/movie_form/title_field/title_field_bloc.dart';
import '../../bloc/movies/movie_bloc.dart';
import '../../bloc/movies/movie_event.dart';
import '../../data/repository/movie_repository.dart';
import '../../functions/show_snackbar.dart';
import '../../injection.dart';
import '../global_widget/barrel.dart';
import '../../theme/color.dart';
import '../../theme/constants.dart';

class CreateMoviePage extends StatelessWidget {
  final String? imageUrl;
  static String id = "CreateMoviePage";
  const CreateMoviePage({
    Key? key,
    this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: false,
        extendBody: true,
        body: CreateMoviePageBody());
  }
}

class CreateMoviePageBody extends StatefulWidget {
  const CreateMoviePageBody({
    Key? key,
  }) : super(key: key);

  @override
  State<CreateMoviePageBody> createState() => _CreateMoviePageBodyState();
}

class _CreateMoviePageBodyState extends State<CreateMoviePageBody> {
  late TitleFieldBloc _titleFieldBloc;
  late PublishYearBloc _publishYearBloc;
  late ImageFieldBloc _imageFieldBloc;

  late MovieFormBloc _movieFormBloc;

  late MovieCrudBloc _movieCrudBloc;

  @override
  void initState() {
    super.initState();

    _titleFieldBloc = TitleFieldBloc(InitialState(''));

    _publishYearBloc = PublishYearBloc(InitialState(''));
    _imageFieldBloc =
        ImageFieldBloc(InitialState(File('')), getIt<ImagePicker>());

    _movieFormBloc = MovieFormBloc(
      titleFieldBloc: _titleFieldBloc,
      publishYearBloc: _publishYearBloc,
      imageFieldBloc: _imageFieldBloc,
    );

    _movieCrudBloc = MovieCrudBloc(movieRepository: getIt<MovieRepository>());
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => _movieFormBloc),
        BlocProvider(create: (context) => _titleFieldBloc),
        BlocProvider(create: (context) => _publishYearBloc),
        BlocProvider(create: (context) => _imageFieldBloc),
        BlocProvider(create: (context) => _movieCrudBloc)
      ],
      child: BlocConsumer<MovieCrudBloc, MovieCrudState>(
        listener: (context, state) {
          if (state is MovieCrudFailed) {
            showSnackBar(context: context, message: 'OPeration failed');
          }

          if (state is MovieCrudSuccessful) {
            //if edit operation is succesfull
//Make request to [MovieBloc] to fetch updated list of movies from endpoint
            BlocProvider.of<MovieBloc>(context).add(MovieFetchedEvent());

            navigateBackToHomePage(context);
          }
        },
        builder: (context, state) {
          return LoadingOverlay(
            isLoading: state is MovieCrudLoading,
            child: Stack(children: [
              const ReusableBottomCurves(),
              Positioned(
                top: _mediaQuery.height * 0.038,
                right: 0,
                left: 0,
                bottom: _mediaQuery.height * 0.00,
                child: const InputAndForm(),
              ),
            ]),
          );
        },
      ),
    );
  }
}

class InputAndForm extends StatelessWidget {
  const InputAndForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: _mediaQuery.height * 1,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: kkMargin),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: kkHeightFromTop),
              Text(
                'Create a new movie',
                style: Theme.of(context)
                    .textTheme
                    .headline3
                    ?.copyWith(color: AppColor.whiteColor),
              ),
              const SizedBox(height: 40),

              //*movie -title

              BlocBuilder<TitleFieldBloc, ValidationState<String>>(
                builder: (context, state) {
                  return ReusableTextField(
                      hintText: 'Title',
                      onChanged: (x) => context.read<TitleFieldBloc>().add(x),
                      errorText: state is InvalidState ? 'Invalid title' : '');
                },
              ),

              //*publish year

              BlocBuilder<PublishYearBloc, ValidationState<String>>(
                builder: (context, state) {
                  return ReusableTextField(
                      inputType: TextInputType.number,
                      hintText: 'Publish year',
                      onChanged: (x) {
                        context.read<PublishYearBloc>().add(x);
                      },
                      errorText: state is InvalidState
                          ? 'Invalid year .example 2022'
                          : '');
                },
              ),
              const SizedBox(height: 12),

              //Movie poster

              BlocBuilder<ImageFieldBloc, ValidationState<File?>>(
                builder: (context, state) {
                  return GestureDetector(
                    onTap: () => context
                        .read<ImageFieldBloc>()
                        .add(const ImageFieldEvent()),
                    child: DottedBorder(
                      color: AppColor.whiteColor,
                      borderType: BorderType.RRect,
                      radius: const Radius.circular(kkBorderRadius),
                      child: Container(
                        height: _mediaQuery.height * 0.25,
                        decoration: BoxDecoration(
                          color: AppColor.whiteColor.withOpacity(0.1),
                          border: Border.all(
                            color: AppColor.whiteColor,
                            style: BorderStyle.none,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            state is ValidState
                                ? Expanded(
                                    child: Image.file(
                                      state.data!,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Center(
                                    child: Text(
                                    'Upload an image here',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        ?.copyWith(color: AppColor.whiteColor),
                                  ))
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),

              //Action buttons
              Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Expanded(child: ButtonWithBorder()),
                  const SizedBox(width: 15),
                  Expanded(
                      child: ReusableButton(
                    label: 'Submit',
                    onPressed: () {
                      final state =
                          BlocProvider.of<MovieFormBloc>(context).state.data;

                      context.read<MovieCrudBloc>().add(MovieAddedEvent(
                          title: state.title,
                          productionYear: state.publishYear,
                          imagePath: state.imageFile));
                    },
                  )),
                ],
              ),
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }
}

void navigateBackToHomePage(BuildContext context) {
  Navigator.pop(context);
}
