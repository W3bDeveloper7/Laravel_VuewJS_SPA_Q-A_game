<?php



/*

|--------------------------------------------------------------------------

| Web Routes

|--------------------------------------------------------------------------

|

| Here is where you can register web routes for your application. These

| routes are loaded by the RouteServiceProvider within a group which

| contains the "web" middleware group. Now create something great!

|

*/



Route::get('/', function () {

    return view('welcome');

});



Auth::routes();





Route::group(['middleware' => ['web', 'login']], function () {

    Route::get('/{any}', 'QuizController@index')->where('any', '.*');

    Route::get('/quiz', 'QuizController@quiz')->name('quiz');

    Route::group(['prefix' => '/'], function () {

        Route::post('/save_question', 'QuizController@saveQuestion')->name('save_question');

        Route::post('/save_game', 'QuizController@saveGame')->name('save_game');

        Route::post('/save_result', 'QuizController@saveResult')->name('save_result');

        Route::post('/get_question_list', 'QuizController@getQuestionsList')->name('get_question_list');

        Route::post('/get_games_list', 'QuizController@getGamesList')->name('get_games_list');

        Route::post('/delete_question', 'QuizController@deleteQuestion')->name('delete_question');

        Route::post('/delete_game', 'QuizController@deleteGame')->name('delete_game');

        Route::post('/get_question_data', 'QuizController@getQuestionData')->name('get_question_data');

        Route::post('/get_game_data', 'QuizController@getGameData')->name('get_game_data');

        Route::post('/update_game_questions', 'QuizController@updateGameQuestions')->name('update_game_questions');

        Route::post('/trigger_event', 'QuizController@triggerEvent')->name('trigger_event');

        Route::post('/get_group_game_results', 'QuizController@getGroupGameResults')->name('get_group_game_results');

    });

});
