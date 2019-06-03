<?php

namespace App\Http\Controllers;

use App\Answer;
use App\Events\QuestionEvent;
use App\Game;
use App\GameItem;
use App\GameResult;
use App\Question;
use App\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class QuizController extends Controller
{
    public function index()
    {
        return view('quiz');
    }
    public function quiz()
    {
        return view('quiz');
    }

    public function saveQuestion(Request $request)
    {
        $question = $request['question'];
        $correctAnswer = $request['correctAnswer'];
        $answers = $request['answers'];


        $strError = "";
        $result = "success";

        $question = Question::firstOrNew(array('question' => $question));
        $question->user_id = Auth::id();

        if (!$question->save()) {
            $strError = "Can not create question! Please try again.";
            $result = "";
        }
        Answer::where('question_id', $question->id)->delete();

        foreach ($answers as $key => $answer) {

            $arrKey = explode("_", $key);
            $key = $arrKey[1];

            if ($key == $correctAnswer) {
                $correctAnswerStatus = "Y";
            } else {
                $correctAnswerStatus = "N";
            }

            Answer::create([
                'question_id' => $question->id,
                'user_id' => Auth::id(),
                'answer' => $answer,
                'status' => $correctAnswerStatus
            ]);
        }

        header('Content-Type: application/json');
        echo json_encode(array(
            'result' => $result,
            'error' => $strError
        ));

    }

    public function saveGame(Request $request)
    {
        $title = $request['title'];
        $id = $request['id'];
        $strSelectedItems = $request['arrSelectedItems'];
        $selectedUser = $request['selectedUser'];
        $arrSelectedItems = explode(",", $strSelectedItems);


        $strError = "";
        $result = "success";

        if (empty($id)) {
            $game = Game::firstOrNew(array('title' => $title));
            $game->user_id = Auth::id();
            $game->for_specific_user = $selectedUser;

            if (!$game->save()) {
                $strError = "Can not create game! Please try again.";
                $result = "";
            }

            //-- Link questions to new game
            if (!empty($arrSelectedItems[0])) {
                foreach ($arrSelectedItems as $item) {
                    GameItem::create([
                        'game_id' => $game->id,
                        'question_id' => $item
                    ]);
                }
            }

        } else {
            $game = Game::find($id);
            $game->title = $title;
            $game->for_specific_user = $selectedUser;
            $game->save();
        }

        header('Content-Type: application/json');
        echo json_encode(array(
            'result' => $result,
            'error' => $strError,
            'game_id' => $game->id
        ));
    }

    public function saveResult(Request $request)
    {
        $game_id = $request['game_id'];
        $game_type = $request['game_type'];
        $game_code = $request['game_code'];
        $data = $request['data'];
        $strError = "";
        $result = "success";

        foreach ($data['questions'] as $key => $question) {
            GameResult::create([
                'user_id' => Auth::id(),
                'game_id' => $game_id,
                'question_id' => $question,
                'answer_id' => $data['answers'][$key],
                'status' => $data['status'][$key] ? 'Y' : 'N',
                'game_type' => $game_type ? 'P' : 'G',
                'time' => $data['time'][$key],
                'game_code' => $game_code
            ]);
        }

        header('Content-Type: application/json');
        echo json_encode(array(
            'result' => $result,
            'error' => $strError
        ));
    }

    public function getGroupGameResults(Request $request)
    {

        $game_type = $request['game_type'];
        $game_code = $request['game_code'];
        $strError = "";
        $result = "success";

        $gameResult=GameResult::where('game_type',$game_type ? 'P' : 'G')->where('game_code',$game_code)->get();
        $users=User::all();
        $users = $users->mapWithKeys(function($user, $key) {
            return [$user->id => $user];
        });


        header('Content-Type: application/json');
        echo json_encode(array(
            'result' => $result,
            'error' => $strError,
            'data' => $gameResult,
            'users' => $users
        ));
    }

    public function getQuestionsList(Request $request)
    {
        $user_id = $request['user_id'];
        $filtered = $request['filtered'];
        $game_id = $request['game_id'];
        $strError = "";
        $result = "success";


        if ($filtered && !empty($game_id)) {
            $arrQuestionsIds = [];
            $questions_linked = Game::find($game_id)->questions;
            if (!empty($questions_linked)) {
                foreach ($questions_linked as $question) {
                    $arrQuestionsIds[] = $question->id;
                }
            }

            $questions = Question::where('user_id', $user_id)->whereNotIn('id', $arrQuestionsIds)->get();
        } else {
            $questions = Question::where('user_id', $user_id)->get();
        }

        if (count($questions) < 1) {
            $strError = "No questions found!";
            $result = "";
        }

        $users = User::where('id','!=',Auth::id())->get();

        return response()
            ->json([
                'result' => $result,
                'error' => $strError,
                'questions' => $questions,
                'users' => $users
            ]);
    }

    public function getGamesList(Request $request)
    {
        $user_id = $request['user_id'];
        $strError = "";
        $result = "success";


        //$games = Game::where('user_id', $user_id)->get();
        $games = Game::all();
        if (count($games) < 1) {
            $strError = "No games found!";
            $result = "";
        }

        return response()
            ->json([
                'result' => $result,
                'error' => $strError,
                'games' => $games,
            ]);
    }

    public function deleteQuestion(Request $request)
    {
        $id = $request['id'];
        $strError = "";
        $result = "success";


        $question = Question::find($id);
        Answer::where('question_id', $question->id)->delete();

        if (!$question->delete()) {
            $strError = "Question can't be deleted";
            $result = "";
        }

        return response()
            ->json([
                'result' => $result,
                'error' => $strError
            ]);
    }

    public function deleteGame(Request $request)
    {
        $id = $request['id'];
        $strError = "";
        $result = "success";


        $game = Game::find($id);
        GameItem::where('game_id', $game->id)->delete();

        if (!$game->delete()) {
            $strError = "Game can't be deleted";
            $result = "";
        }

        return response()
            ->json([
                'result' => $result,
                'error' => $strError
            ]);
    }

    public function getQuestionData(Request $request)
    {
        $question_id = $request['question_id'];
        $strError = "";
        $result = "success";


        $question = Question::find($question_id);


        return response()
            ->json([
                'result' => $result,
                'error' => $strError,
                'question' => $question
            ]);
    }

    public function getGameData(Request $request)
    {
        $game_id = $request['game_id'];
        $strError = "";
        $result = "success";


        $game = Game::find($game_id);

        $game = Game::find($game_id);
        $arrGameCodes=GameResult::where('game_id',$game_id)->where('game_code','like',$game_id.'%')->pluck('game_code');
        $arrCodes=[];
        if(count($arrGameCodes)>0){
            foreach ($arrGameCodes as $code){
                $arrCodeItem=explode('_',$code);
                $arrCodes[]=$arrCodeItem[1];
            }
            $intMaxCode=max($arrCodes);
            $strGameCode=$game_id."_".((int)$intMaxCode+1);
        }else{
            $strGameCode=$game_id."_1";
        }


        return response()
            ->json([
                'result' => $result,
                'error' => $strError,
                'game' => $game,
                'game_code' => $strGameCode
            ]);
    }

    public function triggerEvent(Request $request)
    {
        $game_id = $request['game_id'];
        $user_id = $request['user_id'];
        $question_id = $request['question_id'];
        $strError = "";
        $result = "success";

        $objQuestion = [
            'game_id' => $game_id,
            'user_id' => $user_id,
            'question_id' => $question_id,
            'result' => '',
            'status' => true
        ];

        event(new QuestionEvent($objQuestion, Auth::user()));

        return response()
            ->json([
                'result' => $result,
                'error' => $strError
            ]);
    }


    public function updateGameQuestions(Request $request)
    {
        $game_id = $request['game_id'];
        $question_id = $request['question_id'];
        $status = $request['status'];
        $strError = "";
        $result = "success";

        //-- Check if this question is already in the game
        $gameItem = GameItem::where('game_id', $game_id)->where('question_id', $question_id)->first();
        $gameItems = GameItem::where('game_id', $game_id)->get();

        if ($status) {
            if ($gameItem) {
                $strError = "This question already added to current game";
                $result = "";
            } else {
                if (count($gameItems) < 10) {
                    GameItem::create([
                        'game_id' => $game_id,
                        'question_id' => $question_id
                    ]);
                } else {
                    $strError = "WARNING! Max 10 questions are allowed in one game!";
                    $result = "";
                }
            }
        } else {
            if ($gameItem) {
                $gameItem->delete();
            }
        }


        return response()
            ->json([
                'result' => $result,
                'error' => $strError,
                'count' => count($gameItems)
            ]);
    }
}
