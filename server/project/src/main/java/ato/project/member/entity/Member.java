package ato.project.member.entity;

import ato.project.diary.entity.Diary;
import jakarta.persistence.*;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;


@Entity
@Data
@NoArgsConstructor
public class Member {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long memberId;

    @Column(nullable = false)
    private String authentication;

    @OneToMany(mappedBy = "member", fetch = FetchType.LAZY)
    private List<Diary> diary;

}
