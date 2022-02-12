import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_overlay/loading_overlay.dart';
import 'package:movie_app_task/bloc/form_bloc/validation_state.dart';
import 'package:movie_app_task/bloc/movie_crud/movie_crud_bloc.dart';
import 'package:movie_app_task/bloc/movie_form/image_field/image_field_bloc.dart';
import 'package:movie_app_task/bloc/movie_form/movie_form/movie_form_bloc.dart';
import 'package:movie_app_task/bloc/movie_form/publish_year_field/publish_year_bloc.dart';
import 'package:movie_app_task/bloc/movie_form/title_field/title_field_bloc.dart';
import 'package:movie_app_task/data/repository/movie_repository.dart';
import 'package:movie_app_task/injection.dart';
import 'package:movie_app_task/pages/global_widget/reusable_button.dart';
import 'package:movie_app_task/pages/global_widget/reusable_curves.dart';
import 'package:movie_app_task/pages/login/login_page.dart';
import 'package:movie_app_task/theme/color.dart';
import 'package:movie_app_task/theme/constants.dart';

class CreateMoviePage extends StatelessWidget {
  static String id = "CreateMoviePage";
  const CreateMoviePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      extendBody: true,
      body: CreateMoviePageBody(),
    );
  }
}

class CreateMoviePageBody extends StatefulWidget {
  const CreateMoviePageBody({Key? key}) : super(key: key);

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
    _imageFieldBloc = ImageFieldBloc(InitialState(''), getIt<ImagePicker>());

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
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                backgroundColor: AppColor.errorColor,
                behavior: SnackBarBehavior.floating,
                content: Row(children: [
                  const Icon(
                    Icons.cancel_outlined,
                    color: AppColor.whiteColor,
                  ),
                  const SizedBox(width: 8),
                  Text('Operation failed',
                      style: Theme.of(context).textTheme.subtitle1?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppColor.whiteColor))
                ])));
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

              BlocBuilder<ImageFieldBloc, ValidationState<String>>(
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
                                      File(state.data),
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
                          imagePath: state.imagePath));
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

class ButtonWithBorder extends StatelessWidget {
  const ButtonWithBorder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {},
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: Text('Cancel'),
      ),
      style: OutlinedButton.styleFrom(
        backgroundColor: Colors.transparent,
        onSurface: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kkBorderRadius),
          side: const BorderSide(color: AppColor.whiteColor, width: 1.5),
        ),
      ),
    );
  }
}
